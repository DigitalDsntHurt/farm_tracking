class AddTotalDthToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :total_dth, :integer
  end
end
