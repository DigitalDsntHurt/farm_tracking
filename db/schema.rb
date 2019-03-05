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

ActiveRecord::Schema.define(version: 20190305163514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crops", force: :cascade do |t|
    t.string "crop"
    t.string "crop_variety"
    t.boolean "seed_treatment"
    t.float "avg_seed_treatment_duration_days"
    t.float "ideal_seed_treatment_duration_days"
    t.float "calculated_seed_oz_to_soak_per_desired_flat"
    t.float "ideal_seed_oz_to_soak_per_desired_flat"
    t.float "avg_alltime_seed_oz_per_flat"
    t.float "avg_6month_seed_oz_per_flat"
    t.float "avg_6week_seed_oz_per_flat"
    t.float "ideal_seed_oz_per_flat"
    t.float "avg_days_to_first_transplant"
    t.float "ideal_days_to_first_transplant"
    t.float "avg_alltime_days_to_harvest"
    t.float "avg_6month_days_to_harvest"
    t.float "avg_6week_days_to_harvest"
    t.float "ideal_days_to_harvest"
    t.float "avg_alltime_yield_per_flat_oz"
    t.float "avg_6month_yield_per_flat_oz"
    t.float "avg_6week_yield_per_flat_oz"
    t.float "sale_price_per_oz"
    t.float "sale_price_per_8oz"
    t.float "sale_price_per_16oz"
    t.float "sale_price_per_live_flat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "ideal_treatment_days"
    t.float "avg_treatment_days"
    t.float "ideal_propagation_days"
    t.float "avg_propagation_days"
    t.float "ideal_system_days"
    t.float "avg_system_days"
    t.float "ideal_post_treatment_dth"
    t.float "avg_post_treatment_dth"
    t.float "ideal_total_dth"
    t.float "avg_total_dth"
    t.float "ideal_soak_seed_oz_per_flat"
    t.float "avg_soak_seed_oz_per_flat"
    t.float "ideal_sew_seed_oz_per_flat"
    t.float "avg_sew_seed_oz_per_flat"
    t.float "avg_yield_per_flat_oz"
    t.string "seed_supplier"
    t.float "ideal_yield_per_flat_oz"
  end

  create_table "farm_ops_dos", force: :cascade do |t|
    t.string "verb"
    t.date "date"
    t.string "crop"
    t.string "variety"
    t.string "customer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "completed_on"
  end

  create_table "nutrient_solutions", force: :cascade do |t|
    t.date "date_mixed"
    t.bigint "reservoir_id"
    t.string "system"
    t.integer "reservoir_fill_volume_liters"
    t.string "topup_or_reset"
    t.string "ingredient1"
    t.integer "ingredient1_qty_ml"
    t.string "ingredient2"
    t.integer "ingredient2_qty_ml"
    t.string "ingredient3"
    t.integer "ingredient3_qty_ml"
    t.string "ingredient4"
    t.integer "ingredient4_qty_ml"
    t.string "ingredient5"
    t.integer "ingredient5_qty_ml"
    t.string "ingredient6"
    t.integer "ingredient6_qty_ml"
    t.string "ingredient7"
    t.integer "ingredient7_qty_ml"
    t.string "ingredient8"
    t.integer "ingredient8_qty_ml"
    t.string "ingredient9"
    t.integer "ingredient9_qty_ml"
    t.string "ingredient10"
    t.integer "ingredient10_qty_ml"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservoir_id"], name: "index_nutrient_solutions_on_reservoir_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer"
    t.string "day_of_week"
    t.date "date"
    t.integer "qty_oz"
    t.string "crop"
    t.string "variety"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "cancelled_on"
  end

  create_table "reservoirs", force: :cascade do |t|
    t.string "name"
    t.integer "size_liters"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduleds", force: :cascade do |t|
    t.string "verb"
    t.date "date"
    t.string "crop"
    t.string "variety"
    t.string "customer"
    t.string "order"
    t.date "completed_on"
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
    t.float "seed_weight_oz"
    t.string "seed_media_treatment_notes"
    t.date "first_emerge_date"
    t.date "full_emerge_date"
    t.string "emergence_notes"
    t.date "date_of_first_transplant"
    t.date "date_of_second_transplant"
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
    t.bigint "room_id"
    t.integer "current_system_id"
    t.boolean "exclude_from_freshlist"
    t.boolean "force_onto_freshlist"
    t.string "sewn_for"
    t.integer "crop_id"
    t.index ["current_system_id"], name: "index_seed_flats_on_current_system_id"
    t.index ["room_id"], name: "index_seed_flats_on_room_id"
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
    t.integer "crop_id"
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
    t.boolean "retired"
    t.integer "flat_slots"
    t.date "retired_on"
    t.index ["room_id"], name: "index_systems_on_room_id"
  end

  add_foreign_key "nutrient_solutions", "reservoirs"
  add_foreign_key "seed_flat_updates", "seed_flats"
  add_foreign_key "seed_flats", "rooms"
  add_foreign_key "seed_flats", "seed_treatments", column: "seed_treatments_id"
  add_foreign_key "systems", "rooms"
end
