class Author < ActiveRecord::Base
  default_scope { includes(:person).references(:person) }

  belongs_to :publication
  belongs_to :person
  has_many :people
  accepts_nested_attributes_for :person

  has_one :participant, through: :person
  has_one :member, through: :person

  delegate :firstName, :to => :person, :allow_nil => false
  delegate :lastName, :to => :person, :allow_nil => false
  delegate :email, :to => :person, :allow_nil => true

end
