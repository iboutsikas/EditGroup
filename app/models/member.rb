class Member < ActiveRecord::Base
  scope :extended, -> { eager_load(:person,
                                   :participant,
                                   personal_websites: :website_template)
                      }
  scope :normal, -> { select("*") }
  default_scope { eager_load(:person)}
  #default_scope { select("members.id, isAdmin, avatar, encrypted_password, invitation_token, current_sign_in_at, last_sign_in_at,current_sign_in_ip, last_sign_in_ip, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, members.person_id, members.participant_id, firstName, lastName, participants.title").joins(:person).joins(:participant) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :participant, dependent: :destroy
  belongs_to :person, dependent: :destroy
  has_many :personal_websites, -> { extended }, dependent: :destroy
  has_many :website_templates, through: :personal_websites

  has_many :authors, through: :person
  has_many :publications, through: :authors
  has_many :journals, through: :publications
  has_many :conferences, through: :publications
  has_many :participations, through: :participant
  has_many :projects, through: :participations

  accepts_nested_attributes_for :participant
  accepts_nested_attributes_for :person
  accepts_nested_attributes_for :personal_websites, allow_destroy: true
  attr_accessor :personal_websites_attributes
  accepts_nested_attributes_for :website_templates

  delegate :firstName, :lastName, :full_name, to: :person, allow_nil: true
  delegate :title, :administrative_title, :participant_email, to: :participant, allow_nil: true

  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, :multiline => true }
  validates :bio, presence: true

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def publications_to_delete
    ####### RETURNIGN ALL PUBLIATIONS CHANGE
    #Publication.find_by_sql(["select distinct * from publications, authors where publications.id = authors.publication_id AND authors.person_id NOT IN (SELECT person_id FROM members WHERE NOT members.id = ?)", self.id])
  end

  def resend_invitation(sender)
    if self.invitation_accepted_at.nil?
      Member.invite!({email: self.email}, sender)
      true
    else
      false
    end
  end

  def invitation_pending?
    self.invitation_accepted_at.nil?
  end

  def auth_mail
    self.email
  end

  def build_unused_websites
    all_templates = WebsiteTemplate.all
    used = self.personal_websites.map { |p| p.website_template }
    available_websites = all_templates - used
    available_websites.each { |w| self.personal_websites.build( website_template_id: w.id) }
  end
end
