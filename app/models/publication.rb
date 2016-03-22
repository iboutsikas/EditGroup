class Publication < ActiveRecord::Base
  has_many :authors
  has_many :people, through: :authors
  has_one :conference
  has_one :journal
  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :journal
  accepts_nested_attributes_for :conference
end
