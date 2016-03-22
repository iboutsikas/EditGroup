class Conference < ActiveRecord::Base
  belongs_to :publication, inverse_of: :conference
end
