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

ActiveRecord::Schema.define(version: 20180904192400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  add_foreign_key "seed_flats", "seed_treatments", column: "seed_treatments_id"
end
