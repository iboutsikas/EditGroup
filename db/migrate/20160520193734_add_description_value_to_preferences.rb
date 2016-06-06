class AddDescriptionValueToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :description, :string
    add_column :preferences, :value, :string
    remove_column :preferences, :citation_style
  end
end
