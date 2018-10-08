class AddColsToSeedFlatsForAutoCutSheet < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_flats, :exclude_from_freshlist, :boolean
  	add_column :seed_flats, :force_onto_freshlist, :boolean
  end
end
