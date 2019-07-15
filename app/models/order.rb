class Order < ApplicationRecord

	before_create :set_standing_order_to_false :capitalize_day_of_week

	private

	def set_standing_order_to_false
		unless self.standing_order == true
			self.standing_order = false
		end
	end

	def capitalize_day_of_week
		self.day_of_week = self.day_of_week.capitalize unless self.day_of_week == nil
	end
end
