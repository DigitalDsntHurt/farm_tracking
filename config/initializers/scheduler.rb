require 'rufus-scheduler'

=begin
scheduler = Rufus::Scheduler.new


##
## ## On Wednesday at 1am, schedule Sunday's Dos
##
scheduler.cron '0 1 * * 3' do
	@today = Date.today
	@orders = Order.where(cancelled_on: nil).sort_by(&:day_of_week)
	@instructions = []

	@orders.each{|order|

		@crop = Crop.where(id: order.crop_id)[0]
		
		if @crop.ideal_treatment_days > 0 # crops for seed treatment
			@instruction = {}
			@instruction[:order_id] = order.id # set instruction order
			@instruction[:date] = OpsCal.set_ops_day_of_week(@crop,order) # sort out instruction date for next day of week
			@instruction[:verb] = "soak"
	        @instruction[:crop_id] = @crop.id # set instruction crop
	        @instruction[:qty] = OpsCal.soak_quantity(@crop,order) # set instruction qty (OUNCES)
	        @instruction[:qty_units] = "oz" # set instruction qty_units

	        @instructions << @instruction

		else # crops for dry seed sewing
			@instruction = {}
			@instruction[:order_id] = order.id # set instruction order		
			@instruction[:date] = OpsCal.set_ops_day_of_week(@crop,order) # sort out instruction date for next day of week
			@instruction[:verb] = "sew" # set instruction verb
			@instruction[:crop_id] = @crop.id # set instruction crop
			@instruction[:qty] = OpsCal.sew_quantity(@crop,order) # set instruction qty (FLATS)
			@instruction[:qty_units] = "flats" # set instruction qty_units
			
			@instructions << @instruction
		end
	}

	@sew = @instructions.select{|i| i[:verb] == "sew" }.select{|i| i[:date].sunday? }
	@soak = OpsCal.aggreagte_soak_quantities(@instructions.select{|i| i[:verb] == "soak" }.select{|i| i[:date].sunday? })

	FarmOpsDo.create(@sew)
	FarmOpsDo.create(@soak)
end


##
## ## On Friday at 1am, schedule Tuesday + Thursday's Dos
##
scheduler.cron '0 1 * * 5' do
	@today = Date.today
	@orders = Order.where(cancelled_on: nil).sort_by(&:day_of_week)
	@instructions = []

	@orders.each{|order|

		@crop = Crop.where(id: order.crop_id)[0]
		
		if @crop.ideal_treatment_days > 0 # crops for seed treatment
			@instruction = {}
			@instruction[:order_id] = order.id # set instruction order
			@instruction[:date] = OpsCal.set_ops_day_of_week(@crop,order) # sort out instruction date for next day of week
			@instruction[:verb] = "soak"
	        @instruction[:crop_id] = @crop.id # set instruction crop
	        @instruction[:qty] = OpsCal.soak_quantity(@crop,order) # set instruction qty (OUNCES)
	        @instruction[:qty_units] = "oz" # set instruction qty_units

	        @instructions << @instruction

		else # crops for dry seed sewing
			@instruction = {}
			@instruction[:order_id] = order.id # set instruction order		
			@instruction[:date] = OpsCal.set_ops_day_of_week(@crop,order) # sort out instruction date for next day of week
			@instruction[:verb] = "sew" # set instruction verb
			@instruction[:crop_id] = @crop.id # set instruction crop
			@instruction[:qty] = OpsCal.sew_quantity(@crop,order) # set instruction qty (FLATS)
			@instruction[:qty_units] = "flats" # set instruction qty_units
			
			@instructions << @instruction
		end
	}

	@sew = @instructions.select{|i| i[:verb] == "sew" }.select{|i| i[:date].sunday? }
	@tuesday_soak = OpsCal.aggreagte_soak_quantities(@instructions.select{|i| i[:verb] == "soak" }.select{|i| i[:date].tuesday? })
	@thursday_soak = OpsCal.aggreagte_soak_quantities(@instructions.select{|i| i[:verb] == "soak" }.select{|i| i[:date].thursday? })

	FarmOpsDo.create(@sew)
	FarmOpsDo.create(@tuesday_soak)
	FarmOpsDo.create(@thursday_soak)
end


=end