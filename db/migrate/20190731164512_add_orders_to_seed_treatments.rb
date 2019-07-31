class AddOrdersToSeedTreatments < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_treatments, :orders, :string
  end
end
