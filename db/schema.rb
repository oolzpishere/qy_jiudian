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

ActiveRecord::Schema.define(version: 2019_08_13_161129) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.date "sale_from"
    t.date "sale_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conferences_hotels", id: false, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.integer "hotel_id", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.integer "twin_beds"
    t.integer "queen_bed"
    t.integer "three_beds"
    t.integer "other_twin_beds"
    t.integer "twin_beds_price"
    t.integer "queen_bed_price"
    t.integer "three_beds_price"
    t.integer "other_twin_beds_price"
    t.integer "breakfast", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identifies", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.string "unionid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unionid"], name: "index_identifies_on_unionid", unique: true
    t.index ["user_id"], name: "index_identifies_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "group"
    t.integer "count"
    t.integer "conference_id"
    t.integer "hotel_id"
    t.string "room_type"
    t.string "names"
    t.string "contact"
    t.string "phone"
    t.integer "price"
    t.integer "breakfast"
    t.date "checkin"
    t.date "checkout"
    t.integer "nights"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_orders_on_conference_id"
    t.index ["hotel_id"], name: "index_orders_on_hotel_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "order_id"
    t.string "names"
    t.string "room_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_rooms_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
