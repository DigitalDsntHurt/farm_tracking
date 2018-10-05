class AddCurrentSystemToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_flats, :current_system, foreign_key: true
  end
end
