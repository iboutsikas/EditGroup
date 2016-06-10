class AddStudentMembers < ActiveRecord::Migration
  def change
    add_column :members, :isStudent, :boolean
    add_column :members, :member_from, :date
    add_column :members, :member_to, :date
  end
end
