class AddDbCropToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :crop_id, :integer
  end
end
