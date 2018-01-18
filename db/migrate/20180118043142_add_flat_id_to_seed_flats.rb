class AddFlatIdToSeedFlats < ActiveRecord::Migration[5.0]
  def change
  	add_column :seed_flats, :flat_id, :string
  end
end
