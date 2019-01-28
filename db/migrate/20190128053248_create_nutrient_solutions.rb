class CreateNutrientSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :nutrient_solutions do |t|
      t.date :date_mixed
      t.references :reservoir, foreign_key: true
      t.string :system
      t.integer :reservoir_fill_volume_liters
      t.string :topup_or_reset
      t.string :ingredient1
      t.integer :ingredient1_qty_ml
      t.string :ingredient2
      t.integer :ingredient2_qty_ml
      t.string :ingredient3
      t.integer :ingredient3_qty_ml
      t.string :ingredient4
      t.integer :ingredient4_qty_ml
      t.string :ingredient5
      t.integer :ingredient5_qty_ml
      t.string :ingredient6
      t.integer :ingredient6_qty_ml
      t.string :ingredient7
      t.integer :ingredient7_qty_ml
      t.string :ingredient8
      t.integer :ingredient8_qty_ml
      t.string :ingredient9
      t.integer :ingredient9_qty_ml
      t.string :ingredient10
      t.integer :ingredient10_qty_ml

      t.timestamps
    end
  end
end
