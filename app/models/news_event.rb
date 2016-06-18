class NewsEvent < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  def date_formatted
    date.strftime("%B %d %Y")
  end
end
