class TeamMembersShift < ApplicationRecord
	belongs_to :team_member

	after_validation :set_paid_to_false

	private
	
	def set_paid_to_false
		if self.paid == nil
			self.paid = false
		end
	end
end
