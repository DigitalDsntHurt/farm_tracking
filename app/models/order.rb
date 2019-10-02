class Order < ApplicationRecord

	before_create :set_standing_order_to_false, :calculate_first_delivery_date

	private

	def set_standing_order_to_false
		unless self.standing_order == true
			self.standing_order = false
		end
	end

	def calculate_first_delivery_date
		crop = Crop.where(id: self.crop_id)[0]
		today = Date.today

		if today.tuesday? or today.thursday? or today.sunday?
			start_date = today + 1
		elsif today.monday? or today.wednesday? or today.saturday?
			start_date = today + 2	
		else # if today.friday?
			start_date = today + 3
		end

		self.calculated_first_delivery_date = start_date + crop.ideal_total_dth
	end
end
