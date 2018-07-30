class AddFormerFlatIdToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_flats, :former_flat_id, :string
  end
end
