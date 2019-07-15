class Order < ApplicationRecord

	before_create :set_standing_order_to_false 

	private

	def set_standing_order_to_false
		unless self.standing_order == true
			self.standing_order = false
		end
	end
end
