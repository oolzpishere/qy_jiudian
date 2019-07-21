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

ActiveRecord::Schema.define(version: 2019_07_21_101159) do

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
    t.integer "twin_and_queen_price"
    t.integer "three_beds_price"
    t.integer "other_twin_beds_price"
    t.integer "breakfast", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "group"
    t.integer "count"
    t.string "names"
    t.string "contact"
    t.integer "room"
    t.integer "price"
    t.integer "breakfast"
    t.integer "room_number"
    t.date "checkin"
    t.date "checkout"
    t.integer "nights"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
