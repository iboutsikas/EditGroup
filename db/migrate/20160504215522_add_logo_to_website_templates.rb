class AddLogoToWebsiteTemplates < ActiveRecord::Migration
  def change
    add_column :website_templates, :logo, :string
  end
end
