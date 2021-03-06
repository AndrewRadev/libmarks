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

ActiveRecord::Schema.define(version: 20160228153237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider"
    t.string   "token"
    t.string   "scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id", "provider", "token"], name: "index_authentications_on_user_id_and_provider_and_token", using: :btree

  create_table "project_connections", force: :cascade do |t|
    t.integer  "user_id",                       null: false
    t.integer  "project_id",                    null: false
    t.integer  "relationship_type", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_connections", ["user_id", "project_id"], name: "index_project_connections_on_user_id_and_project_id", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "homepage_url",    null: false
    t.string   "language"
    t.text     "github_info"
    t.datetime "info_fetched_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "github_username"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "project_connections", "projects"
  add_foreign_key "project_connections", "users"
end
