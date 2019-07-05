class CalendarsController < ApplicationController
  
  ##
  ## ##
  ## ## ## BEGIN HELPER METHODS
  ## ##
  ##

  helper_method :all_active_standing_orders, :filter_orders_for_soak, :filter_orders_for_sew, :turn_soak_orders_into_instructions, :turn_sew_orders_into_instructions, :days_ref, :date_of_next, :reduce_date_to_ops_date, :get_soak_quantity, :group_instructions_by_date, :crop_aggregate_instructions, :get_action_day, :orders_to_soak_instructions, :reduce_wday_to_ops_day, :aggregate_crop_instructions, :orders_to_sew_instructions, :get_sew_quantity, :orders_to_harvest_instructions, :filter_orders_for_harvest, :num_flats_to_harvest

	def all_active_standing_orders
		Order.where(cancelled_on: nil).where(standing_order: true)
	end

	def filter_orders_for_soak(orders)
		orders.select{|order| Crop.where(id: order.crop_id)[0].ideal_treatment_days > 0 }
	end

	def filter_orders_for_sew(orders)
		orders.select{|order| Crop.where(id: order.crop_id)[0].ideal_treatment_days == 0 }
	end

	def filter_orders_for_harvest(orders)
		orders.select{|order| Customer.where(id: order.customer_id)[0].name != "overgrow" }
	end

	def days_ref
		["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
	end

	def get_action_day(order)
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

	def date_of_next(day_of_week_string)
		date  = Date.parse(day_of_week_string)
		delta = date > Date.today ? 0 : 7
	 	date + delta
	end	

	def reduce_date_to_ops_date(date)
		@return = date
		if date.tuesday?
	    	@return - 1
		elsif date.thursday?
			@return - 1
		elsif date.saturday?
			@return - 1
		elsif date.sunday?
			@return - 2
		else
			@return
		end
	end

	def reduce_wday_to_ops_day(wday)
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

	def get_soak_quantity(order)
		@crop = Crop.where(id: order.crop_id)[0]
		((order.qty_oz / @crop.ideal_yield_per_flat_oz).ceil * @crop.ideal_soak_seed_oz_per_flat).round(2)
	end

	def get_sew_quantity(order)
		# this calculates a number of FLATS
		@crop = Crop.where(id: order.crop_id)[0]
		(order.qty_oz / @crop.ideal_yield_per_flat_oz).ceil
	end

	def turn_soak_orders_into_instructions(orders)
		# accepts an array or Orders
		@instructions = []
		orders.each{|order|
			@hsh = {}
			@hsh[:verb] = "soak"
			@hsh[:date] = reduce_date_to_ops_date(date_of_next(get_action_day(order)))
			@hsh[:qty] = get_soak_quantity(order)
			@hsh[:qty_units] = "oz"
			@hsh[:order_id] = order.id
			@instructions << @hsh
		}
		@instructions
		# returns an array of hashes where each hash is an instruction
	end

	def orders_to_soak_instructions(orders)
		# accepts an array or Orders
		@instructions = []
		orders.each{|order|
			@hsh = {}
			@hsh[:verb] = "soak"
			@hsh[:day] = reduce_wday_to_ops_day(get_action_day(order))
			@hsh[:qty] = get_soak_quantity(order)
			@hsh[:qty_units] = "oz"
			@hsh[:order_id] = order.id
			@instructions << @hsh
		}
		@instructions
		# returns an array of hashes where each hash is an instruction
	end	

	def orders_to_sew_instructions(orders)
		# accepts an array of Orders
		@instructions = []
		orders.each{|order|
			@hsh = {}
			@hsh[:verb] = "sew"
			@hsh[:day] = reduce_wday_to_ops_day(get_action_day(order))
			@hsh[:qty] = get_sew_quantity(order)
			@hsh[:qty_units] = "flat"
			@hsh[:order_id] = order.id
			@instructions << @hsh
		}
		@instructions
		# returns an array of hashes where each hash is an instruction
	end		

	def turn_sew_orders_into_instructions(orders)

	end	

	def orders_to_harvest_instructions(orders)
		# accepts an array or Orders
		@instructions = []
		orders.each{|order|
			@hsh = {}
			@hsh[:verb] = "harvest"
			@hsh[:day] = order.day_of_week
			@hsh[:qty] = order.qty_oz
			@hsh[:qty_units] = "oz"
			@hsh[:order_id] = order.id
			@instructions << @hsh
		}
		@instructions
		# returns an array of hashes where each hash is an instruction
	end

	def num_flats_to_harvest(order_id)
		@order = Order.where(id: order_id)[0]
		@crop = Crop.where(id: @order.crop_id)[0]
		(@order.qty_oz / @crop.ideal_yield_per_flat_oz).round(2).ceil
	end

	def group_instructions_by_date(instructions)
		# accepts an array of hashes where each hash is an instruction
		instructions.group_by{|instruction| instruction[:date] }
		# returns an array of arrays with two elements
		# first element is a date
		# second element is an array of hashes where each hash is an instruction
	end

	def crop_aggregate_instructions(date_grouped_instructions)
		# accepts an array of arrays with two elements where first element is a date and second element is an array of hashes where each hash is an instruction
		@crop_aggregated_instructions = []
		date_grouped_instructions.each{|array|
			@aggregate_arr = []
			array[1].group_by{|old_hsh| Order.where(id: old_hsh[:order_id])[0].crop_id }.each{|old_hsh|
				@new_hsh = {}
				@new_hsh[:verb] = old_hsh[1][0][:verb]
				#@new_hsh[:date] = old_hsh[:date]
				@new_hsh[:qty] = 0
				@new_hsh[:qty_units] = old_hsh[1][0][:qty_units]
				@new_hsh[:order_ids] = []
				#if old_hsh[1].count > 1
					old_hsh[1].each{|hsh|
						@new_hsh[:qty] += hsh[:qty]
						@new_hsh[:order_ids] << hsh[:order_id]
					}
				#else
				#	@new_hsh[:qty] += hsh[:qty]
				#	@new_hsh[:order_ids] << hsh[:order_id]
				#end
				@new_hsh[:qty].round(2)

				@aggregate_arr << @new_hsh
			}
			@crop_aggregated_instructions << [array[0], @aggregate_arr]
		}
		@crop_aggregated_instructions
		#@crop_aggregated_instructions
		# returns an array of arrays with two elements where first element is a date and second element is an array of hashes where each hash is an instruction
	end

	#
	## newer
	#
	def aggregate_crop_instructions(instructions)
		# accepts 

		@return = []

		instructions.group_by{|original_instruction_hsh| original_instruction_hsh[:day] }.each{|day_group|
			@pertinent_day = day_group[0]
			@pertinent_day_instructions = day_group[1]

			@pertinent_day_instructions.group_by{|day_grouped_original_instruction_hsh| Order.where(id: day_grouped_original_instruction_hsh[:order_id])[0].crop_id }.each{|crop_group|
				@pertinent_crop_id = crop_group[0]
				@pertinent_crop_instructions = crop_group[1]
				@new_hsh = {}
				@new_hsh[:day] = @pertinent_day
				@new_hsh[:verb] = day_group[1][1][:verb]
				@new_hsh[:qty] = 0
				@new_hsh[:qty_units] = day_group[1][1][:qty_units]
				@new_hsh[:order_ids] = []
				@pertinent_crop_instructions.each{|hsh|
					@new_hsh[:qty] += hsh[:qty]
					@new_hsh[:order_ids] << hsh[:order_id]
				}
				@return << @new_hsh	
			}
		}

		@return.group_by{|hsh| hsh[:day] }
		# returns 
	end

	##
	## ## 
	## ## ## END HELPER METHODS
	## ##
	##



  def ops

  	#
  	## Create Soak Schedule
  	#
  	@soak_orders = filter_orders_for_soak(all_active_standing_orders)
  	@soak_instructions = orders_to_soak_instructions(@soak_orders)
  	@final_soak_instructions = aggregate_crop_instructions(@soak_instructions)
  	#@final_soak_instructions = crop_aggregate_instructions(group_instructions_by_date(turn_soak_orders_into_instructions(@soak_orders)))

  	#
  	## Create Sew Schedule
  	#
  	@sew_orders = filter_orders_for_sew(all_active_standing_orders)
  	@sew_instructions = orders_to_sew_instructions(@sew_orders)
  	@final_sew_instructions = aggregate_crop_instructions(@sew_instructions)
  	#@sew_instructions = crop_aggregate_instructions(group_instructions_by_date(turn_sew_orders_into_instructions(@sew_orders)))

  	#
  	## Create Harvest Schedule
  	#
	@harvest_orders = filter_orders_for_harvest(all_active_standing_orders)
  	@harvest_instructions = orders_to_harvest_instructions(@harvest_orders).group_by{|inst| inst[:day] }

  end

  def harvest
	@harvest_orders = filter_orders_for_harvest(all_active_standing_orders)
  	@harvest_instructions = orders_to_harvest_instructions(@harvest_orders).group_by{|inst| inst[:day] }  	
  end


end
