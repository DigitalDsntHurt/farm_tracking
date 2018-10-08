class AddMoreColsToSeedFlatsForAutoCutSheet < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_flats, :sewn_for, :string
  end
end
