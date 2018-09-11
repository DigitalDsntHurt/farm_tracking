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

ActiveRecord::Schema.define(version: 20180911153841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seed_flat_updates", force: :cascade do |t|
    t.bigint "seed_flat_id"
    t.string "update_type"
    t.datetime "update_datetime"
    t.integer "origin_system_id"
    t.integer "destination_system_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_system_id"], name: "index_seed_flat_updates_on_destination_system_id"
    t.index ["origin_system_id"], name: "index_seed_flat_updates_on_origin_system_id"
    t.index ["seed_flat_id"], name: "index_seed_flat_updates_on_seed_flat_id"
  end

  create_table "seed_flats", id: :serial, force: :cascade do |t|
    t.date "started_date"
    t.string "crop"
    t.string "crop_variety"
    t.string "seed_brand"
    t.string "medium"
    t.string "format"
    t.float "seed_weight"
    t.string "seed_wt_units"
    t.string "seed_media_treatment_notes"
    t.date "first_emerge_date"
    t.date "full_emerge_date"
    t.string "emergence_notes"
    t.date "date_of_first_transplant"
    t.string "first_transplant_notes"
    t.date "date_of_second_transplant"
    t.string "second_transplant_notes"
    t.date "harvested_on"
    t.float "harvest_weight_oz"
    t.float "hrvst_wt_lbs"
    t.integer "harvest_week"
    t.string "harvest_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "flat_id"
    t.date "date_of_third_transplant"
    t.string "former_flat_id"
    t.bigint "seed_treatments_id"
    t.integer "days_to_harvest_from_sew"
    t.integer "days_to_harvest_from_soak"
    t.index ["seed_treatments_id"], name: "index_seed_flats_on_seed_treatments_id"
  end

  create_table "seed_treatments", force: :cascade do |t|
    t.datetime "soak_start_datetime"
    t.string "seed_crop"
    t.string "seed_variety"
    t.string "seed_brand"
    t.float "seed_quantity_oz"
    t.string "soak_solution"
    t.float "soak_duration_hrs"
    t.string "post_soak_treatment"
    t.text "soak_notes"
    t.date "germination_start_date"
    t.string "germination_vehicle"
    t.date "first_emerge_date"
    t.date "full_emerge_date"
    t.integer "days_to_full_emergence"
    t.text "emergence_notes"
    t.date "killed_on"
    t.date "planned_date_of_first_flat_sew"
    t.date "date_of_first_flat_sew"
    t.date "date_of_last_flat_sew"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "destination_flat_ids", default: [], array: true
    t.boolean "finished"
    t.date "soak_start_date"
  end

  create_table "systems", force: :cascade do |t|
    t.bigint "room_id"
    t.date "build_date"
    t.string "system_type"
    t.string "system_dimensions"
    t.integer "levels"
    t.text "lights"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "system_name"
    t.index ["room_id"], name: "index_systems_on_room_id"
  end

  add_foreign_key "seed_flat_updates", "seed_flats"
  add_foreign_key "seed_flats", "seed_treatments", column: "seed_treatments_id"
  add_foreign_key "systems", "rooms"
end
