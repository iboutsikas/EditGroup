class Participation < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant
  has_one :person,through: :participant

  accepts_nested_attributes_for :participant

  def build_person(attributes =  nil)
    if attributes
      self.person = Person.new(attributes)
    else
      self.person = Person.new
    end
  end

  def full_name
    self.participant.full_name
  end

  def title
    self.participant.title
  end

  def administrative_title
    self.participant.administrative_title
  end

  def email
    self.participant.email
  end
end
