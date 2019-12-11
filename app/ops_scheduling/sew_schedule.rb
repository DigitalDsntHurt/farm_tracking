class SewSchedule

	##
	## ## methods that work on dates and times
	##	
	def self.days_ref
		["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
	end

	def self.get_action_day(order)
		wday = ""
		@crop = Crop.where(id: order.crop_id)[0]
		@total_dth = @crop.ideal_treatment_days + @crop.ideal_propagation_days + @crop.ideal_system_days
		if @total_dth % 7 == 0
	    	wday += "#{order.day_of_week}"
	    else
	    	@days_ref_index = days_ref.index(order.day_of_week) - (@total_dth % 7)
	        wday += days_ref[@days_ref_index]
	    end
	    wday
	end

	def self.reduce_wday_to_ops_day(wday)
		if wday == "Tuesday"
	    	"Monday"
		elsif wday == "Thursday"
			"Wednesday"
		elsif wday == "Saturday"
			"Friday"
		elsif wday == "Sunday"
			"Friday"
		else
			wday
		end
	end	

	def self.date_of_next(day)
	  date  = Date.parse(day)
	  delta = date > Date.today ? 0 : 7
	  date + delta
	end	


	##
	## ## methods that work on Orders and Crops models
	##

	def self.get_orders_for_sew
		@orders = Order.where(cancelled_on: nil).where(standing_order: true) # gets all active standing orders
		@orders.select{|order| Crop.where(id: order.crop_id)[0].ideal_treatment_days == 0 } # filters standing orders on crops that do not require soak
	end	

	def self.get_sew_quantity(order)
		# this calculates a number of FLATS
		@crop = Crop.where(id: order.crop_id)[0]
		(order.qty_oz / @crop.ideal_yield_per_flat_oz).ceil
	end


	##
	## ## methods that translate orders to a sew schedule
	##

	def self.orders_to_sew_instructions(orders)
		# accepts an array of Orders
		@instructions = []
		orders.each{|order|
			@hsh = {}
			@hsh[:verb] = "sew"
			@hsh[:day] = reduce_wday_to_ops_day(get_action_day(order))
			@hsh[:qty] = get_sew_quantity(order)
			@hsh[:qty_units] = "flats"
			@hsh[:order_id] = order.id
			@instructions << @hsh
		}
		@instructions
		# returns an array of hashes where each hash is an instruction
	end	

	def self.aggregate_sew_instructions(instructions)
		@return = []

		instructions.group_by{|original_instruction_hsh| original_instruction_hsh[:day] }.each{|day_group|
			@pertinent_day = day_group[0]
			@pertinent_day_instructions = day_group[1]

			@pertinent_day_instructions.group_by{|day_grouped_original_instruction_hsh| Order.where(id: day_grouped_original_instruction_hsh[:order_id])[0].crop_id }.each{|crop_group|
				@pertinent_crop_id = crop_group[0]
				@pertinent_crop_instructions = crop_group[1]
				@new_hsh = {}
				@new_hsh[:verb] = day_group[1][1][:verb]
				@new_hsh[:date] = date_of_next(@pertinent_day)
				@new_hsh[:qty] = 0
				@new_hsh[:qty_units] = day_group[1][1][:qty_units]
				@new_hsh[:order_ids] = []
				@pertinent_crop_instructions.each{|hsh|
					@new_hsh[:qty] += hsh[:qty]
					@new_hsh[:order_ids] << hsh[:order_id]
					@new_hsh[:crop_id] = Order.where(id: hsh[:order_id])[0].crop_id
				}
				@return << @new_hsh	
			}
		}

		@return
	end

	###tentative vv

	def self.create_weekly_sew_schedule_array
  		## creates an array of hashes. each hash is a sew instruction that can be accepted by FarmOpsDo.create()
  		aggregate_sew_instructions(orders_to_sew_instructions(get_orders_for_sew))
	end

	def self.instantiate_weekly_sew_schedule_db_dos
		create_weekly_sew_schedule_array.each{|hsh|
			FarmOpsDo.create(hsh)
		}
	end

end