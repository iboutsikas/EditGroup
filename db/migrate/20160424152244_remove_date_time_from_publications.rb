class RemoveDateTimeFromPublications < ActiveRecord::Migration
  def change
    remove_column :publications,:date_time
  end
end
