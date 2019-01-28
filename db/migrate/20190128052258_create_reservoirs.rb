class CreateReservoirs < ActiveRecord::Migration[5.1]
  def change
    create_table :reservoirs do |t|
      t.string :name
      t.integer :size_liters
      t.string :brand

      t.timestamps
    end
  end
end
