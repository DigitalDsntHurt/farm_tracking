class AddCurrentSystemToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	#add_column :seed_flats, :current_system
  	#add_reference :seed_flats, :current_system, index: true
  	#add_foreign_key :seed_flats, :current_system

  	add_column :seed_flats, :current_system, :integer
  	add_index :seed_flats, :current_system
  end
end
