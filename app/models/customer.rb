class Customer < ApplicationRecord

	before_create :downcase_customer_name
	before_update :downcase_customer_name
	
	private

	def downcase_customer_name
		self.name = self.name.downcase
	end

end
