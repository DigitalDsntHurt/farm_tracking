class AddDummiesToSeedTreatments < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_treatments, :order_dummies, :string
  end
end
