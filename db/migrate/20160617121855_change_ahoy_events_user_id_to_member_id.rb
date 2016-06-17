class ChangeAhoyEventsUserIdToMemberId < ActiveRecord::Migration
  def change
    rename_column :ahoy_events, :user_id, :member_id
  end
end
