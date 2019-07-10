class CreateTeamMembersShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members_shifts do |t|
      t.integer :team_member_id
      t.date :shift_date
      t.float :shift_hrs
      t.date :paid_date

      t.timestamps
    end
  end
end
