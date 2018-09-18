class AddRoomToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	add_reference :seed_flats, :room, foreign_key: true
  end
end
