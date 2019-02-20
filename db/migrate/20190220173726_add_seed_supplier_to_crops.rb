class AddSeedSupplierToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :seed_supplier, :string
  end
end
