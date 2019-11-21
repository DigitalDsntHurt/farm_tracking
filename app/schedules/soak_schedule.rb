class SoakSchedule
	def self.add(a,b)
		a+b
	end

	def self.get_orders_count
		Order.all.count
	end
end