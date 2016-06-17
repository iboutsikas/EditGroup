class Person < ActiveRecord::Base
  has_one :participant, inverse_of: :person
  has_one :member, through: :participant, inverse_of: :person
  has_many :projects, through: :participations
  has_many :publications, through: :authors
  has_many :authors, dependent: :destroy

  validates :firstName, presence: true
  validates :lastName, presence: true

  def full_name
    self.lastName + " " + self.firstName
  end

  def full_name_for_select2
    if self.isMember?
      "~" + self.firstName + " " + self.lastName
    else
      full_name
    end
  end

  def isMember?
    !self.member.nil?
  end

end
