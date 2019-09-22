class Harvest < ApplicationRecord
	has_one :customer, foreign_key: 'customer_id'
	has_one :crop, foreign_key: 'crop_id'
	has_one :order, foreign_key: 'order_id'

	before_save :set_completed_to_false

	private

	def set_completed_to_false
		if self.completed == nil
			self.completed = false
		end
	end
end
