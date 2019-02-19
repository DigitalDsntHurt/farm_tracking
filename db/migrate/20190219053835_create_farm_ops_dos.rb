class CreateFarmOpsDos < ActiveRecord::Migration[5.1]
  def change
    create_table :farm_ops_dos do |t|
      t.string :verb
      t.date :date
      t.string :crop
      t.string :variety
      t.string :customer

      t.timestamps
    end
  end
end
