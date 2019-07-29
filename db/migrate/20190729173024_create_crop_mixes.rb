class CreateCropMixes < ActiveRecord::Migration[5.1]
  def change
    create_table :crop_mixes do |t|
      t.string :name
      t.integer :crop_one_id
      t.float :crop_one_parts
      t.integer :crop_two_id
      t.float :crop_two_parts
      t.integer :crop_three_id
      t.float :crop_three_parts
      t.integer :crop_four_id
      t.float :crop_four_parts
      t.integer :crop_five_id
      t.float :crop_five_parts
      t.integer :crop_six_id
      t.float :crop_six_parts
      t.integer :crop_seven_id
      t.float :crop_seven_parts
      t.integer :crop_eight_id
      t.float :crop_eight_parts

      t.timestamps
    end
  end
end
