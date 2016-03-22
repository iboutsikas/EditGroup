class Journal < ActiveRecord::Base
  belongs_to :publication, inverse_of: :journal
end
