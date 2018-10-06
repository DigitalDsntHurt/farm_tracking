class ChangeSeedWeightColName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :seed_flats, :seed_weight, :seed_weight_oz
  	remove_column :seed_flats, :seed_wt_units, :string
  end
end
