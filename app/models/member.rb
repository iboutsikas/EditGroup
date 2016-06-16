require 'pry'

class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :participant, dependent: :destroy
  belongs_to :person, dependent: :destroy
  has_many :personal_websites, dependent: :destroy
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
  accepts_nested_attributes_for :website_templates

  mount_uploader :avatar, AvatarUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, :multiline => true }
  validates :bio, presence: true

  def firstName
    self.person.firstName
  end

  def lastName
    self.person.lastName
  end

  def full_name
    self.person.full_name
  end

  def publications_to_delete
    ####### RETURNIGN ALL PUBLIATIONS CHANGE
    Publication.find_by_sql(["select * from publications, authors, members where publications.id = authors.publication_id and authors.person_id = members.person_id and authors.person_id = ?", self.person_id])
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

end
