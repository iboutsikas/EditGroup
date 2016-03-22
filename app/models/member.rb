class Member < ActiveRecord::Base
  belongs_to :participant, dependent: :destroy
  belongs_to :person, dependent: :destroy
  accepts_nested_attributes_for :participant
  accepts_nested_attributes_for :person

  def firstName
    self.person.firstName
  end

  def lastName
    self.person.lastName
  end

end
