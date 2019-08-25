class AddUpdateDateToSeedFlatUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flat_updates, :update_date, :date
  end
end
