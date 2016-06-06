class AddPriorityToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :priority, :integer
  end
end
