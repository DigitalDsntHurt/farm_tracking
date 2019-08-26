class ChangeColumnsInTeamMembersShifts < ActiveRecord::Migration[5.1]
  def change
  	rename_column :team_members_shifts, :shift_date, :planned_shift_date
  	rename_column :team_members_shifts, :shift_hrs, :planned_shift_hrs
  end
end
