class Project < ActiveRecord::Base
  has_many :participations, dependent: :destroy, inverse_of: :project
  has_many :participants, through: :participations
end
