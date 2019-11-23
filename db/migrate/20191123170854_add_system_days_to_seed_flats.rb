class AddSystemDaysToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :system_days, :integer
  end
end
