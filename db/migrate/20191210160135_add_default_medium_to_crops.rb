class AddDefaultMediumToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :default_medium, :string
  end
end
