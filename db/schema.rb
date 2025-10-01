# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_01_110716) do
  create_table "car_features", force: :cascade do |t|
    t.integer "car_id", null: false
    t.integer "feature_id", null: false
    t.boolean "is_standard"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_features_on_car_id"
    t.index ["feature_id"], name: "index_car_features_on_feature_id"
  end

  create_table "car_purchases", force: :cascade do |t|
    t.integer "car_id", null: false
    t.integer "person_id", null: false
    t.integer "dealership_id", null: false
    t.date "purchase_date"
    t.decimal "price_paid"
    t.string "financing_type"
    t.integer "kilometers_at_purchase"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_purchases_on_car_id"
    t.index ["dealership_id"], name: "index_car_purchases_on_dealership_id"
    t.index ["person_id"], name: "index_car_purchases_on_person_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "manufacturer_id", null: false
    t.string "model"
    t.integer "year"
    t.decimal "base_price"
    t.string "color"
    t.string "engine_size"
    t.string "transmission"
    t.integer "kilometers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer_id"], name: "index_cars_on_manufacturer_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "province"
    t.string "country"
    t.integer "population"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealerships", force: :cascade do |t|
    t.integer "city_id", null: false
    t.string "name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_dealerships_on_city_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.decimal "base_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.integer "founded_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "city_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "age"
    t.string "income_bracket"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_people_on_city_id"
  end

  add_foreign_key "car_features", "cars"
  add_foreign_key "car_features", "features"
  add_foreign_key "car_purchases", "cars"
  add_foreign_key "car_purchases", "dealerships"
  add_foreign_key "car_purchases", "people"
  add_foreign_key "cars", "manufacturers"
  add_foreign_key "dealerships", "cities"
  add_foreign_key "people", "cities"
end
