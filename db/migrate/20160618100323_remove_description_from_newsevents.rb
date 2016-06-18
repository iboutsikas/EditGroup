class RemoveDescriptionFromNewsevents < ActiveRecord::Migration
  def change
    remove_column :news_events, :description
  end
end
