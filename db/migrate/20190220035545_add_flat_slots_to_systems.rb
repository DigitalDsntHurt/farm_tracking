class AddFlatSlotsToSystems < ActiveRecord::Migration[5.1]
  def change
    add_column :systems, :flat_slots, :integer
  end
end
