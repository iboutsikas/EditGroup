class AddMemberIdToPersonalWebsites < ActiveRecord::Migration
  def change
    add_column :personal_websites, :member_id, :integer
    add_index :personal_websites, :member_id
  end
end
