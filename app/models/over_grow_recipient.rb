class OverGrowRecipient < ApplicationRecord

	after_create :downcase_email
	after_update :downcase_email
	validates_uniqueness_of :email

	private

	def downcase_email
		self.email = self.email.downcase
	end
end
