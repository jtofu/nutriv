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

ActiveRecord::Schema.define(version: 2019_04_09_075611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doses", force: :cascade do |t|
    t.bigint "dish_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nutrient_id"
    t.index ["dish_id"], name: "index_doses_on_dish_id"
    t.index ["nutrient_id"], name: "index_doses_on_nutrient_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nutrient_id"
    t.index ["nutrient_id"], name: "index_goals_on_nutrient_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "dish_id"
    t.index ["dish_id"], name: "index_meals_on_dish_id"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "nutrients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit"
    t.string "api_code"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_order_items_on_dish_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "order_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "wechat_id"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "profile_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "doses", "dishes"
  add_foreign_key "doses", "nutrients"
  add_foreign_key "goals", "nutrients"
  add_foreign_key "goals", "users"
  add_foreign_key "meals", "dishes"
  add_foreign_key "meals", "users"
  add_foreign_key "order_items", "dishes"
  add_foreign_key "order_items", "orders"
end
