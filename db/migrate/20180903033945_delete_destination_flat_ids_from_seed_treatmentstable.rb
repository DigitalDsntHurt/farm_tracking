class DeleteDestinationFlatIdsFromSeedTreatmentstable < ActiveRecord::Migration[5.1]
  def change
  	remove_column :seed_treatments, :destination_flat_ids
  end
end
