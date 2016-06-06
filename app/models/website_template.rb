class WebsiteTemplate < ActiveRecord::Base
  has_many :personal_websites, inverse_of: :website_template, dependent: :destroy
  mount_uploader :logo, LogoUploader

  validates :website_name, presence: true
end
