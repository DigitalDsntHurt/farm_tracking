class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :location
      t.string :address

      t.timestamps
    end
  end
end
