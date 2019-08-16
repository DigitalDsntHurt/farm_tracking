class RemoveRowsFromSeedFlats < ActiveRecord::Migration[5.1]
  def change
    remove_column :seed_flats, :date_of_third_transplant, :date
    remove_column :seed_flats, :date_of_second_transplant, :date
    remove_column :seed_flats, :date_of_first_transplant, :date
    remove_column :seed_flats, :emergence_notes, :string
    remove_column :seed_flats, :seed_brand, :string
    remove_column :seed_flats, :crop_variety, :string
    remove_column :seed_flats, :crop, :string
    remove_column :seed_flats, :harvested_for, :integer
    remove_column :seed_flats, :sewn_for, :string
  end
end
