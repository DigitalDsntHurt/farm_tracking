class AddCropIdToOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :crop_id, :integer
  end
end
