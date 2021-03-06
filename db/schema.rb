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

ActiveRecord::Schema.define(version: 2018_12_02_131043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eventcategories", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_eventcategories_on_category_id"
    t.index ["event_id"], name: "index_eventcategories_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.integer "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon_image"
  end

  create_table "tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "event_id", null: false
    t.string "uuid"
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "userevents", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_userevents_on_event_id"
    t.index ["user_id"], name: "index_userevents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "uuid"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon_image"
  end

  add_foreign_key "eventcategories", "categories"
  add_foreign_key "eventcategories", "events"
  add_foreign_key "userevents", "events"
  add_foreign_key "userevents", "users"
end
