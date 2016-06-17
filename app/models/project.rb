require "uri"

class Project < ActiveRecord::Base
  has_many :participations, dependent: :destroy, inverse_of: :project
  has_many :participants, through: :participations

  accepts_nested_attributes_for :participants

  validates :title, presence: true
  validates :motto, presence: true
  validates :description, presence: true

  def website_formatted
    temp = self.website
    return "http://#{temp}" unless temp[/^https?/]
  end

  def video_url_only
    URI.extract(self.video)[0]
  end
end
