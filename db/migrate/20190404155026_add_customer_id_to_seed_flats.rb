class AddCustomerIdToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :customer_id, :integer
  end
end
