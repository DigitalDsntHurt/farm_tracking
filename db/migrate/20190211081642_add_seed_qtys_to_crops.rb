class AddSeedQtysToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :ideal_soak_seed_oz_per_flat, :float
    add_column :crops, :avg_soak_seed_oz_per_flat, :float
    add_column :crops, :ideal_sew_seed_oz_per_flat, :float
    add_column :crops, :avg_sew_seed_oz_per_flat, :float
  end
end
