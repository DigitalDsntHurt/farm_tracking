class AddCropTypeToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :crop_type, :string
  end
end
