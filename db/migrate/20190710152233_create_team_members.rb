class CreateTeamMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members do |t|
      t.string :fname
      t.string :lname
      t.date :start_date
      t.date :birthday
      t.string :phone
      t.string :email
      t.string :address
      t.string :social_links

      t.timestamps
    end
  end
end
