
module OpsCal

	def self.add(x,y)
		x+y
	end

	def self.days_ref
		["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
	end

	def self.date_of_next(day)
		date  = Date.parse(day)
		delta = date > Date.today ? 0 : 7
	 	date + delta
	end	

	def self.adjust_to_ops_day(wday)
		if wday == "Monday"
	    	wday = "Sunday"
		elsif wday == "Wednesday"
			wday = "Tuesday"
		elsif wday == "Friday" or wday == "Saturday"
			wday = "Thursday"
		else
		end

		wday
	end

	def self.set_ops_day_of_week(crop,order)
		wday = ""
		
		# work backward from order day to get instruction day of week
		if crop.ideal_total_dth % 7 == 0
	    	wday += "#{order.day_of_week}"
	    else
	    	@days_ref_index = OpsCal.days_ref.index(order.day_of_week) - (crop.ideal_total_dth % 7)
	        wday += OpsCal.days_ref[@days_ref_index]
	    end

	    # adjust day of week to ops days (Tue, Thu, Sun)
	   	if wday == "Monday"
	    	wday = "Sunday"
		elsif wday == "Wednesday"
			wday = "Tuesday"
		elsif wday == "Friday" or wday == "Saturday"
			wday = "Thursday"
		else
		end

		# get date of next day of week
	    OpsCal.date_of_next(wday)
	end

	def self.soak_quantity(crop,order)
		# this calculates a number of OUNCES
		(order.qty_oz / crop.ideal_yield_per_flat_oz).ceil * crop.ideal_soak_seed_oz_per_flat 
	end

	def self.sew_quantity(crop,order)
		# this calculates a number of FLATS
		(order.qty_oz / crop.ideal_yield_per_flat_oz).ceil
	end

	def self.aggreagte_soak_quantities(instructions)
		soak = []
		instructions.group_by{|i| i[:crop_id]}.each{|i|
			@hsh = {}
			@hsh[:date] = i[1][0][:date]
			@hsh[:verb] = i[1][0][:verb]
			@hsh[:crop_id] = i[1][0][:crop_id]
			@hsh[:qty] = 0
			@hsh[:qty_units] = i[1][0][:qty_units]
			if i[1].count > 1
				i[1].each{|hsh|
					@hsh[:qty] += hsh[:qty] 
				}
				soak << @hsh
			else
				soak << i[1][0]
			end
		}

		soak
	end

end