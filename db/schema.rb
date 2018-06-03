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

ActiveRecord::Schema.define(version: 2018_06_02_103130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "expired_at"
    t.integer "duration_day"
    t.boolean "archived", default: false
    t.string "title"
    t.string "content_type"
    t.bigint "content_id"
    t.index ["archived"], name: "index_announcements_on_archived"
    t.index ["content_type", "content_id"], name: "index_announcements_on_content_type_and_content_id"
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "file"
    t.string "attachmentable_type"
    t.bigint "attachmentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachmentable_type", "attachmentable_id"], name: "index_attachments_on_attachmentable_type_and_attachmentable_id"
  end

  create_table "car_announcements", force: :cascade do |t|
    t.string "make"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_rental_announcements", force: :cascade do |t|
    t.string "pick_up_location"
    t.string "drop_off_location"
    t.boolean "different_location"
    t.datetime "pick_up_time"
    t.datetime "drop_off_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "announcement_id"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "state"
    t.index ["announcement_id"], name: "index_offers_on_announcement_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.bigint "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "announcements", "users"
  add_foreign_key "offers", "announcements"
  add_foreign_key "offers", "users"
end
