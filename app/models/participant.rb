class Participant < ActiveRecord::Base
  belongs_to :person, inverse_of: :participant, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_one :member

  accepts_nested_attributes_for :person

  validates :title, presence: true
  validates :administrative_title, presence: true
  validates :email, presence: true

  def check_if_used_elsewhere(participant)

      raise "error"

  end

  def full_name
    self.person.full_name
  end
end
