class AddCropIdToSeedTreatments < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_treatments, :crop_id, :integer
  end
end
