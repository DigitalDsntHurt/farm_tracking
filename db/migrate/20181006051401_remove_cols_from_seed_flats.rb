class RemoveColsFromSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	remove_column :seed_flats, :first_transplant_notes, :string
  	remove_column :seed_flats, :second_transplant_notes, :string
  end
end
