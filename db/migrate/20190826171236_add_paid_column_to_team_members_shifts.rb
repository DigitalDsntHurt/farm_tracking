class AddPaidColumnToTeamMembersShifts < ActiveRecord::Migration[5.1]
  def change
    add_column :team_members_shifts, :paid, :boolean
  end
end
