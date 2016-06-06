class RemovePublicationsJournals < ActiveRecord::Migration
  def change
    drop_table :conferences
    drop_table :journals
  end
end
