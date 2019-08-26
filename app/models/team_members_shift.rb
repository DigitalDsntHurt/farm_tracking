class TeamMembersShift < ApplicationRecord
	belongs_to :team_member

	validates_presence_of :team_member_id

	after_validation :set_paid_to_false

	private
	
	def set_paid_to_false
		if self.paid == nil
			self.paid = false
		end
	end
end
