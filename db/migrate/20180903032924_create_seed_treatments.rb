class CreateSeedTreatments < ActiveRecord::Migration[5.1]
  def change
    create_table :seed_treatments do |t|
      t.datetime :soak_start_datetime
      t.string :seed_crop
      t.string :seed_variety
      t.string :seed_brand
      t.float :seed_quantity_oz
      t.string :soak_solution
      t.float :soak_duration_hrs
      t.string :post_soak_treatment
      t.text :soak_notes
      t.date :germination_start_date
      t.string :germination_vehicle
      t.date :first_emerge_date
      t.date :full_emerge_date
      t.integer :days_to_full_emergence
      t.text :emergence_notes
      t.date :killed_on
      t.date :planned_date_of_first_flat_sew
      t.date :date_of_first_flat_sew
      t.date :date_of_last_flat_sew
      t.text :destination_flat_ids

      t.timestamps
    end
  end
end
