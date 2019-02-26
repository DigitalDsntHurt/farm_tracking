class AddIdealYieldPerFlatOzToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :ideal_yield_per_flat_oz, :float
  end
end
