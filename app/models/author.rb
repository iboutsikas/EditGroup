class Author < ActiveRecord::Base
  belongs_to :publication
  belongs_to :person
  accepts_nested_attributes_for :person
end
