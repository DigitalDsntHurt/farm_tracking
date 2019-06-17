class AddHarvestedForToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :harvested_for, :integer
  end
end
