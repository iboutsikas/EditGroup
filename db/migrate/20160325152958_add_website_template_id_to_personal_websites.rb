class AddWebsiteTemplateIdToPersonalWebsites < ActiveRecord::Migration
  def change
    add_column :personal_websites, :website_template_id, :integer
    add_index :personal_websites, :website_template_id
  end
end
