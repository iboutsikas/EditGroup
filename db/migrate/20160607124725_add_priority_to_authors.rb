class AddPriorityToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :priority, :integer
  end
end
