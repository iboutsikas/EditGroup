class CreateConferencesJournals < ActiveRecord::Migration
  def change
    create_table "conferences" do |t|
      t.string   "name"
      t.string   "city"
      t.string   "publisher"
      t.string   "location"
    end

    create_table "journals" do |t|
      t.string   "title"
      t.integer  "volume"
      t.integer  "issue"
    end
  end
end
