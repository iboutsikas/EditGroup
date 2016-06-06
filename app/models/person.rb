class Person < ActiveRecord::Base
  has_one :participant, inverse_of: :person
  has_one :member, through: :participant, inverse_of: :person
  has_many :projects, through: :participations
  has_many :publications, through: :authors
  has_many :authors, dependent: :destroy

  validates :firstName, presence: true
  validates :lastName, presence: true

  def full_name
    self.firstName + " " + self.lastName
  end

  def isMember?
    @member = Member.find_by_sql(["select person_id from members where person_id = ?", self.id])
    !@member.empty?
  end

end
