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

ActiveRecord::Schema.define(version: 20191210160135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crop_mixes", force: :cascade do |t|
    t.string "name"
    t.integer "crop_one_id"
    t.float "crop_one_parts"
    t.integer "crop_two_id"
    t.float "crop_two_parts"
    t.integer "crop_three_id"
    t.float "crop_three_parts"
    t.integer "crop_four_id"
    t.float "crop_four_parts"
    t.integer "crop_five_id"
    t.float "crop_five_parts"
    t.integer "crop_six_id"
    t.float "crop_six_parts"
    t.integer "crop_seven_id"
    t.float "crop_seven_parts"
    t.integer "crop_eight_id"
    t.float "crop_eight_parts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string "crop_type"
    t.float "ideal_soak_duration_hrs"
    t.string "default_medium"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "harvest_preferences"
    t.text "delivery_preferences"
    t.text "notes"
  end

  create_table "daily_priorities", force: :cascade do |t|
    t.string "initial"
    t.string "one"
    t.boolean "oneexecuted"
    t.string "two"
    t.boolean "twoexecuted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
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
    t.integer "crop_id"
    t.float "qty"
    t.string "qty_units"
    t.integer "order_id"
    t.integer "treatment_id"
    t.string "order_ids", default: [], array: true
  end

  create_table "friends", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media_unit_costs", force: :cascade do |t|
    t.date "date"
    t.string "media"
    t.float "unit_cost"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.float "qty_oz"
    t.string "crop"
    t.string "variety"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "cancelled_on"
    t.integer "crop_id"
    t.boolean "standing_order"
    t.integer "customer_id"
    t.integer "maturity_days"
    t.text "harvest_preferences"
    t.date "start_date"
    t.date "calculated_first_delivery_date"
  end

  create_table "over_grow_recipients", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "customer_id"
    t.float "harvest_qty_oz"
    t.boolean "finished"
    t.date "update_date"
    t.index ["destination_system_id"], name: "index_seed_flat_updates_on_destination_system_id"
    t.index ["origin_system_id"], name: "index_seed_flat_updates_on_origin_system_id"
    t.index ["seed_flat_id"], name: "index_seed_flat_updates_on_seed_flat_id"
  end

  create_table "seed_flats", id: :serial, force: :cascade do |t|
    t.date "started_date"
    t.string "medium"
    t.string "format"
    t.float "seed_weight_oz"
    t.string "seed_media_treatment_notes"
    t.date "first_emerge_date"
    t.date "full_emerge_date"
    t.date "harvested_on"
    t.float "harvest_weight_oz"
    t.float "hrvst_wt_lbs"
    t.integer "harvest_week"
    t.string "harvest_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "flat_id"
    t.string "former_flat_id"
    t.bigint "seed_treatments_id"
    t.integer "days_to_harvest_from_sew"
    t.integer "days_to_harvest_from_soak"
    t.bigint "room_id"
    t.integer "current_system_id"
    t.boolean "exclude_from_freshlist"
    t.boolean "force_onto_freshlist"
    t.integer "crop_id"
    t.integer "customer_id"
    t.date "anticipated_ready_date"
    t.integer "total_dth"
    t.integer "treatment_days"
    t.integer "propagation_days"
    t.integer "system_days"
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
    t.string "order_ids", default: [], array: true
    t.string "order_dummies"
    t.string "orders"
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
    t.string "pumps"
    t.string "pump_time"
    t.string "current_nutrient_solution"
    t.index ["room_id"], name: "index_systems_on_room_id"
  end

  create_table "team_members", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.date "start_date"
    t.date "birthday"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "social_links"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_members_shifts", force: :cascade do |t|
    t.integer "team_member_id"
    t.date "planned_shift_date"
    t.float "planned_shift_hrs"
    t.date "paid_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "actual_shift_date"
    t.float "actual_shift_hrs"
    t.boolean "paid"
  end

  create_table "weekly_revenues", force: :cascade do |t|
    t.date "week_start_date"
    t.float "revenue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "nutrient_solutions", "reservoirs"
  add_foreign_key "seed_flat_updates", "seed_flats"
  add_foreign_key "seed_flats", "rooms"
  add_foreign_key "seed_flats", "seed_treatments", column: "seed_treatments_id"
  add_foreign_key "systems", "rooms"
end
