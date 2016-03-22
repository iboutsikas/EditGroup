class Participant < ActiveRecord::Base
  belongs_to :person, dependent: :destroy
  has_one :member
  accepts_nested_attributes_for :person

  def check_if_used_elsewhere(participant)

      raise "error"

  end
end
