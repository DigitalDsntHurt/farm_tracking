class CreateOverGrowRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :over_grow_recipients do |t|
      t.string :email

      t.timestamps
    end
  end
end
