class RemoveCityFromConference < ActiveRecord::Migration
  def change
    remove_column :conferences, :city
  end
end
