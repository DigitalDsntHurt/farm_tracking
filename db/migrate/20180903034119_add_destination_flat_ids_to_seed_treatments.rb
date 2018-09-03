class AddDestinationFlatIdsToSeedTreatments < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_treatments, :destination_flat_ids, :text, array:true, default: []
  end
end
