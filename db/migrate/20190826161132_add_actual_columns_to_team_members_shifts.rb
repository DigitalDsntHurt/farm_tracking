class AddActualColumnsToTeamMembersShifts < ActiveRecord::Migration[5.1]
  def change
    add_column :team_members_shifts, :actual_shift_date, :date
    add_column :team_members_shifts, :actual_shift_hrs, :float
  end
end
