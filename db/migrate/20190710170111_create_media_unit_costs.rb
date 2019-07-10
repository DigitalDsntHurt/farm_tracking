class CreateMediaUnitCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :media_unit_costs do |t|
      t.date :date
      t.string :media
      t.float :unit_cost
      t.string :notes

      t.timestamps
    end
  end
end
