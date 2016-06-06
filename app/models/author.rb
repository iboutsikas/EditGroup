class Author < ActiveRecord::Base
  belongs_to :publication
  belongs_to :person
  has_many :people
  accepts_nested_attributes_for :person

end
