class Project < ActiveRecord::Base
  has_many :participations, dependent: :destroy, inverse_of: :project
  has_many :participants, through: :participations

  accepts_nested_attributes_for :participants

  validates :title, presence: true
  validates :motto, presence: true
  validates :description, presence: true
end
