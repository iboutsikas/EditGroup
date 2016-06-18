class ChangeUserItToMemberIdInVisits < ActiveRecord::Migration
  def change
    rename_column :visits, :user_id, :member_id
  end
end
