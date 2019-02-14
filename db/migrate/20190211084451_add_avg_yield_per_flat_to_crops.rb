class AddAvgYieldPerFlatToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :avg_yield_per_flat_oz, :float
  end
end
