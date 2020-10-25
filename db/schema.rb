# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_05_235732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grocery_list_groups", force: :cascade do |t|
    t.string "name"
    t.integer "sort"
    t.bigint "grocery_list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grocery_list_id"], name: "index_grocery_list_groups_on_grocery_list_id"
  end

  create_table "grocery_list_items", force: :cascade do |t|
    t.string "name"
    t.float "cost"
    t.float "qty"
    t.integer "sort"
    t.bigint "grocery_list_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grocery_list_group_id"], name: "index_grocery_list_items_on_grocery_list_group_id"
  end

  create_table "grocery_lists", force: :cascade do |t|
    t.string "name"
    t.boolean "template"
    t.float "total"
    t.float "budget"
    t.float "sales_tax"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_grocery_lists_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "code"
    t.string "value"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "onboarding", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "grocery_list_groups", "grocery_lists"
  add_foreign_key "grocery_list_items", "grocery_list_groups"
  add_foreign_key "grocery_lists", "users"
  add_foreign_key "settings", "users"
end
