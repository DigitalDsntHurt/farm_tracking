class CreateSeedFlats < ActiveRecord::Migration[5.0]
  def change
    create_table :seed_flats do |t|
      t.date :started_date
      t.string :crop
      t.string :crop_variety
      t.string :seed_brand
      t.string :medium
      t.string :format
      t.float :seed_weight
      t.string :seed_wt_units
      t.string :seed_media_treatment_notes
      t.date :first_emerge_date
      t.date :full_emerge_date
      t.string :emergence_notes
      t.date :date_of_first_transplant
      t.string :first_transplant_notes
      t.date :date_of_second_transplant
      t.string :second_transplant_notes
      t.date :harvested_on
      t.float :harvest_weight_oz
      t.float :hrvst_wt_lbs
      t.integer :harvest_week
      t.string :harvest_notes

      t.timestamps
    end
  end
end
