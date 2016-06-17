class Participant < ActiveRecord::Base
  belongs_to :person, inverse_of: :participant, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :projects, through: :participations
  has_one :member

  accepts_nested_attributes_for :person

  validates :title, presence: true
  validates :administrative_title, presence: true
  validates :email, presence: true

  delegate :firstName, :lastName, :full_name, to: :person, allow_nil: true
  delegate :isAdmin, :auth_mail, :isStudent, :bio, :member_from, :member_to, :avatar, to: :member, allow_nil: true

  def check_if_used_elsewhere(participant)

      raise "error"

  end

  def participant_email
    self.email
  end
end
