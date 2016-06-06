class AddContentToNewsEvents < ActiveRecord::Migration
  def change
    add_column :news_events, :content, :text
  end
end
