# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160321223948) do

  create_table "authors", force: :cascade do |t|
    t.string   "person_id"
    t.string   "publication_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "conferences", id: false, force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "publisher"
    t.string   "location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "id"
    t.integer  "publication_id"
  end

  create_table "journals", id: false, force: :cascade do |t|
    t.string   "title"
    t.integer  "volume"
    t.integer  "issue"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "id"
    t.integer  "publication_id"
  end

  create_table "members", force: :cascade do |t|
    t.boolean "isAdmin"
    t.integer "person_id"
    t.integer "participant_id"
  end

  add_index "members", ["participant_id"], name: "index_members_on_participant_id"
  add_index "members", ["person_id"], name: "index_members_on_person_id"

  create_table "news_events", force: :cascade do |t|
    t.date     "date"
    t.string   "description"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "administrative_title"
    t.string   "title"
    t.string   "email"
    t.integer  "person_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "participants", ["person_id"], name: "index_participants_on_person_id"

  create_table "participations", primary_key: "participation_id", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "participations", ["participant_id"], name: "index_participations_on_participant_id"
  add_index "participations", ["project_id"], name: "index_participations_on_project_id"

  create_table "people", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_websites", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "motto"
    t.string   "description"
    t.date     "date_started"
    t.string   "website"
    t.string   "video"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string   "title"
    t.datetime "date_time"
    t.string   "pages"
    t.text     "abstract"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "website_templates", force: :cascade do |t|
    t.string   "website_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
