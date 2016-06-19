class PersonalWebsite < ActiveRecord::Base
#  default_scope { includes(:website_template).references(:website_template) }
  scope :extended, -> {
    eager_load(:website_template)
  }
  belongs_to :member
  belongs_to :website_template, inverse_of: :personal_websites
  has_many :personal_websites, foreign_key: "id"

  accepts_nested_attributes_for :website_template
  accepts_nested_attributes_for :personal_websites

  validates :url, presence: true
  validates :website_template, presence: true

  def website_name
    self.website_template.website_name
  end

  def url_formatted
    logger.info self.url
    temp = self.url
    return /^http/i.match(temp) ? url : "http://#{temp}"
    #return "http://#{temp}" unless temp[/^http?/]
  end
end
