class Person < ActiveRecord::Base
  has_one :participant, inverse_of: :person
  has_many :projects, through: :participations
end
