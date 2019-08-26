class TeamMember < ApplicationRecord
	has_many :team_members_shift, dependent: :destroy
end
