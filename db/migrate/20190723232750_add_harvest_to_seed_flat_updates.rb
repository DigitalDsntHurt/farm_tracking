class AddHarvestToSeedFlatUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flat_updates, :customer_id, :integer
    add_column :seed_flat_updates, :harvest_qty_oz, :float
    add_column :seed_flat_updates, :finished, :boolean
  end
end
