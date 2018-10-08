class CreateCrops < ActiveRecord::Migration[5.1]
  def change
    create_table :crops do |t|
      t.string :crop
      t.string :crop_variety
      t.boolean :seed_treatment
      t.float :avg_seed_treatment_duration_days
      t.float :ideal_seed_treatment_duration_days
      t.float :calculated_seed_oz_to_soak_per_desired_flat
      t.float :ideal_seed_oz_to_soak_per_desired_flat
      t.float :avg_alltime_seed_oz_per_flat
      t.float :avg_6month_seed_oz_per_flat
      t.float :avg_6week_seed_oz_per_flat
      t.float :ideal_seed_oz_per_flat
      t.float :avg_days_to_first_transplant
      t.float :ideal_days_to_first_transplant
      t.float :avg_alltime_days_to_harvest
      t.float :avg_6month_days_to_harvest
      t.float :avg_6week_days_to_harvest
      t.float :ideal_days_to_harvest
      t.float :avg_alltime_yield_per_flat_oz
      t.float :avg_6month_yield_per_flat_oz
      t.float :avg_6week_yield_per_flat_oz
      t.float :sale_price_per_oz
      t.float :sale_price_per_8oz
      t.float :sale_price_per_16oz
      t.float :sale_price_per_live_flat

      t.timestamps
    end
  end
end
