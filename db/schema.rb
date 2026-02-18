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

ActiveRecord::Schema[7.1].define(version: 2026_02_18_185918) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.integer "number_of_adults"
    t.integer "number_of_kids"
    t.date "check_in_date"
    t.date "check_out_date"
    t.string "package"
    t.string "preference_for_confirmation"
    t.text "message"
    t.boolean "newsletter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_programs", force: :cascade do |t|
    t.string "key", null: false
    t.string "title"
    t.jsonb "includes_bullets"
    t.integer "position"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_offer_programs_on_key", unique: true
  end

  create_table "offer_variants", force: :cascade do |t|
    t.bigint "offer_program_id", null: false
    t.integer "people_count", null: false
    t.string "meal_plan", null: false
    t.string "duration_kind", null: false
    t.integer "nights", null: false
    t.string "room_type", null: false
    t.integer "price_ron", null: false
    t.boolean "active", default: true, null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan", "duration_kind", "nights", "room_type"], name: "idx_on_meal_plan_duration_kind_nights_room_type_f76185f98f"
    t.index ["offer_program_id", "people_count"], name: "index_offer_variants_on_offer_program_id_and_people_count"
    t.index ["offer_program_id"], name: "index_offer_variants_on_offer_program_id"
  end

  add_foreign_key "offer_variants", "offer_programs"
end
