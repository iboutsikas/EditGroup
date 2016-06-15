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

ActiveRecord::Schema.define(version: 20160610133837) do

  create_table "authors", force: :cascade do |t|
    t.string   "person_id"
    t.string   "publication_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "priority"
  end

  create_table "conferences", force: :cascade do |t|
    t.string  "name"
    t.string  "publisher"
    t.string  "location"
    t.integer "publication_id"
  end

  add_index "conferences", ["publication_id"], name: "index_conferences_on_publication_id"

  create_table "journals", force: :cascade do |t|
    t.string  "title"
    t.integer "volume"
    t.integer "issue"
    t.integer "publication_id"
  end

  add_index "journals", ["publication_id"], name: "index_journals_on_publication_id"

  create_table "members", force: :cascade do |t|
    t.boolean  "isAdmin"
    t.integer  "person_id"
    t.integer  "participant_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.text     "bio"
    t.string   "avatar"
    t.boolean  "isStudent"
    t.date     "member_from"
    t.date     "member_to"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["invitation_token"], name: "index_members_on_invitation_token", unique: true
  add_index "members", ["invitations_count"], name: "index_members_on_invitations_count"
  add_index "members", ["invited_by_id"], name: "index_members_on_invited_by_id"
  add_index "members", ["participant_id"], name: "index_members_on_participant_id"
  add_index "members", ["person_id"], name: "index_members_on_person_id"
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true

  create_table "news_events", force: :cascade do |t|
    t.date     "date"
    t.string   "description"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "content"
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
    t.integer  "priority"
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
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "member_id"
    t.integer  "website_template_id"
  end

  add_index "personal_websites", ["member_id"], name: "index_personal_websites_on_member_id"
  add_index "personal_websites", ["website_template_id"], name: "index_personal_websites_on_website_template_id"

  create_table "preferences", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.string   "value"
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
    t.string   "pages"
    t.text     "abstract"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
    t.string   "doi"
  end

  create_table "website_templates", force: :cascade do |t|
    t.string   "website_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "logo"
  end

end
