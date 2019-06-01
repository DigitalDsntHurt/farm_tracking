class DashboardsController < ApplicationController

##
## ## helper methods
##
  helper_method :add_shit
  
  def add_shit(n1,n2)
    n1 + n2
  end

  def turn_orders_into_soak_instructions(orders)
    @payload = []
    @days_of_week_ref = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    



    return @payload
  end

  def turn_orders_into_sew_instructions(orders)
    @payload = []
    @days_of_week_ref = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    
    
    
    return @payload
  end

  def day_adjust_dos(input)
    @payload = []
    input.each{|arr|
      if arr[1] == "Monday"
        @payload << [arr[0],"Sunday",arr[2],arr[3],arr[4]]
      elsif arr[1] == "Wednesday"
        @payload << [arr[0],"Tuesday",arr[2],arr[3],arr[4]]
      elsif arr[1] == "Friday"
        @payload << [arr[0],"Thursday",arr[2],arr[3],arr[4]]
      elsif arr[1] == "Saturday"
        @payload << [arr[0],"Thursday",arr[2],arr[3],arr[4]]
      else
        @payload << arr
      end
    }

    return @payload.group_by{|arr| arr[1]}
  end


##
## ## standard controller view methods
##

  def ops_calendar
  # setup calendar cells
    @today = Date.today - 3
    if @today.strftime("%a") == "Mon"
      @start_date = @today
    else
        @start_date = @today
        until @start_date.strftime("%a") == "Mon"
          @start_date -= 1
        end
    end
    @end_date = @start_date+21
    @date_range = (@start_date..@end_date)
    @weeks = @date_range.to_a.in_groups_of(3)


  end












  def soak_sew_cal
    
    #@wtf = SoakSchedule.new("thing").execute


    # setup calendar cells
    @today = Date.today - 7
    if @today.strftime("%a") == "Mon"
      @start_date = @today
    else
        @start_date = @today
        until @start_date.strftime("%a") == "Mon"
          @start_date -= 1
        end
    end
    @end_date = @start_date+60
    @date_range = (@start_date..@end_date)
    @weeks = @date_range.to_a.in_groups_of(7)

    # lookup orders
    @orders = Order.where(cancelled_on: nil)
    @grouped_orders = @orders.group_by{|order| order.day_of_week }

    @days_of_week_ref = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    @to_soak = []
    @to_sew = []

    @orders.sort_by(&:day_of_week).each{|order|
      @arr = []  

      #@days_of_week_ref = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
      #@crop = Crop.where(crop: order.crop).where(crop_variety: order.variety)
      @crop = Crop.where(id: order.crop_id)

      @instruction = []
      if @crop[0].ideal_treatment_days == 0
        @instruction << "sew" 
        @instruction << "#{(order.qty_oz / @crop[0].ideal_yield_per_flat_oz).ceil}" 
        @instruction << "#{Crop.where(id: order.crop_id)[0].crop_variety} #{Crop.where(id: order.crop_id)[0].crop}"
        @instruction << "#{order.customer}"
      else
        @instruction << "soak"
        @instruction << "#{(order.qty_oz / @crop[0].ideal_yield_per_flat_oz).ceil * @crop[0].ideal_soak_seed_oz_per_flat }"
        @instruction << "#{order.variety} #{order.crop}"
        @instruction << "#{order.customer}"
      end

      if @crop[0].ideal_total_dth % 7 == 0
        @instruction.insert(1,"#{order.day_of_week}")
      else
        @ref_index = @days_of_week_ref.index(order.day_of_week) - (@crop[0].ideal_total_dth % 7)
        @instruction.insert(1,@days_of_week_ref[@ref_index])
      end

      @to_soak << @instruction if @instruction[0] == "soak"
      @to_sew << @instruction if @instruction[0] == "sew"
    }

    ##
    ## ## Date Adjustments to Soak schedule
    ##
    @to_soak_day_adjusted = []
    @to_soak.each{|arr|
      if arr[1] == "Monday"
        @to_soak_day_adjusted << [arr[0],"Sunday",arr[2],arr[3],arr[4],false]
      elsif arr[1] == "Wednesday"
        @to_soak_day_adjusted << [arr[0],"Tuesday",arr[2],arr[3],arr[4],false]
      elsif arr[1] == "Friday"
        @to_soak_day_adjusted << [arr[0],"Thursday",arr[2],arr[3],arr[4],false]
      elsif arr[1] == "Saturday"
        @to_soak_day_adjusted << [arr[0],"Thursday",arr[2],arr[3],arr[4],false]
      else
        @to_soak_day_adjusted << arr
      end     
    }
    @grouped_soaks = @to_soak_day_adjusted.group_by{|arr| arr[1]}

    ##
    ## ##  Date Adjustments to Sew schedule
    ##
    @to_sew_day_adjusted = []
    @to_sew.each{|arr|
      if arr[1] == "Monday"
        @to_sew_day_adjusted << [arr[0],"Sunday",arr[2],arr[3],arr[4]]
      elsif arr[1] == "Wednesday"
        @to_sew_day_adjusted << [arr[0],"Tuesday",arr[2],arr[3],arr[4]]
      elsif arr[1] == "Friday"
        @to_sew_day_adjusted << [arr[0],"Thursday",arr[2],arr[3],arr[4]]
      elsif arr[1] == "Saturday"
        @to_sew_day_adjusted << [arr[0],"Thursday",arr[2],arr[3],arr[4]]
      else
        @to_sew_day_adjusted << arr
      end     
    }
    @grouped_sews = @to_sew_day_adjusted.group_by{|arr| arr[1]}

  end


  def calendar
  	
  	@seed_flats = SeedFlat.all
  	@grouped_seed_flats = SeedFlat.all.group_by{ |flat| flat.started_date }
    
    @today = Date.today - 21
    if @today.strftime("%a") == "Mon"
      @start_date = @today
    else
        @start_date = @today
        until @start_date.strftime("%a") == "Mon"
          @start_date -= 1
        end
    end
    @end_date = @start_date+60
    @date_range = (@start_date..@end_date)
    @weeks = @date_range.to_a.in_groups_of(7)

  end

  def sew_calendar
    
    #
    ## setup calendar
    #
    @today = Date.today #- 7
    if @today.strftime("%a") == "Mon"
      @start_date = @today
    else
        @start_date = @today
        until @start_date.strftime("%a") == "Mon"
          @start_date -= 1
        end
    end
    @end_date = @start_date+14
    @date_range = (@start_date..@end_date)
    @weeks = @date_range.to_a.in_groups_of(7)

    #
    ## create soak schedule
    #
    @soak_instructions = []
    @sew_instructions = []
    @orders = Order.where(cancelled_on: nil)#.sort_by(&:day_of_week)

    @orders.each{|order|
      @crop = Crop.where(id: order.crop_id)[0]
      if @crop.ideal_treatment_days == 0
        @instruction = {}
        @instruction[:order_id] = order.id # set instruction order
        @instruction[:date] = OpsCal.set_ops_day(OpsCal.date_of_next(order.day_of_week))
        @instruction[:verb] = "sew"
        @instruction[:crop_id] = @crop.id # set instruction crop
        @instruction[:qty] = OpsCal.sew_quantity(@crop,order) # set instruction qty (FLATS)
        @instruction[:qty_units] = "flats" # set instruction qty_units
        @sew_instructions << @instruction
      else
        @instruction = {}
        @instruction[:order_id] = order.id # set instruction order
        @instruction[:date] = OpsCal.set_ops_day(OpsCal.date_of_next(order.day_of_week))
        @instruction[:verb] = "soak"
        @instruction[:crop_id] = @crop.id # set instruction crop
        @instruction[:qty] = OpsCal.soak_quantity(@crop,order) # set instruction qty (OUNCES)
        @instruction[:qty_units] = "oz" # set instruction qty_units
        @soak_instructions << @instruction
      end
    }

    @to_soak = OpsCal.aggreagte_soak_or_sew_quantities(@soak_instructions)
    @to_sew = OpsCal.aggreagte_soak_or_sew_quantities(@sew_instructions)

    #
    ## create sew schedule
    #
    
  end


  def old_pipeline
    @propagation_shelf = SeedFlat.where(:date_of_first_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
    @sue_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where(:date_of_second_transplant => nil).where(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
    @david_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where.not(:date_of_second_transplant => nil).where(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
    @live_storage_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where.not(:date_of_second_transplant => nil).where.not(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
  end

  def pipeline
    @rooms = Room.all
    @propagation_system_ids = System.all.where(system_name: "propagation").to_a.map{|s| s.id}
    @propagation_system_ids = System.where('system_name LIKE ?', '%propagation%').all.to_a.map{|s| s.id}
  end

  def page_pipeline
    @rooms = Room.where(name: "Page St")
    @propagation_system_ids = System.all.where(system_name: "propagation").where(room_id: 1).to_a.map{|s| s.id}
  end  

  def warehouse_pipeline
    @rooms = Room.where(name: "FitzHouse")
    @propagation_system_ids = System.all.where(system_name: "propagation").where(room_id: 2).to_a.map{|s| s.id}
  end   

  def transplant_calendar
    @today = Date.today
    @propagation_system_ids = System.where(system_name: "propagation").map{|system| system.id }
    @propagation_flats = []
    @propagation_system_ids.each{|system_id|
      SeedFlat.where(current_system_id: system_id).where(harvested_on: nil).each{|flat| @propagation_flats << flat }
    }
    @propagation_flats.map!{|flat| [flat,((Date.today-flat.started_date).to_i) - (Crop.where(id: flat.crop_id)[0].ideal_propagation_days)] }.sort_by!{|flat,num| num }
    #@propagation_flats
  
  end 

  def harvest_calendar
    #
    ## setup calendar
    #
    @start_date = Date.today #- 7
    @end_date = @start_date+90
    @date_range = (@start_date..@end_date)


    #
    ##
    #
    @active_flats = SeedFlat.where(harvest_weight_oz: nil).where.not(current_system_id: nil).where.not(flat_id: "").order(:started_date)
    @grouped_orders = Order.where(cancelled_on: nil).reject{|order| Customer.where(id: order.customer_id)[0].name == "overgrow" }.group_by(&:day_of_week)
    @orders = Order.where(cancelled_on: nil).reject{|order| Customer.where(id: order.customer_id)[0].name == "overgrow" }
  end  

  def calculator
  end

  def calculate
    #@result = HarvestCalculator.send(params[:crop], params[:weight])
    @result = HarvestCalculator.send(:hc, *[params[:crop], params[:weight], params[:date]])
    render :calculator
  end

  def cutsheet
    # @harvest_avgs = [{:crop => "cropname", :avg_dtm => 15, :avg_oz_per_flat => 8 },{:crop => "cropname", :avg_dtm => 15, :avg_oz_per_flat => 8 }]
    @flats_for_harvest = SeedFlat.where(:harvest_weight_oz => nil).where("started_date < ?",(Date.today-14))

    @harvest_avgs = []
    @harvested_flats = SeedFlat.where.not(harvest_weight_oz: 0.0).where.not(harvest_weight_oz: nil)
    @crops = @harvested_flats.pluck(:crop).uniq
#    @crops.each{|crop_name|
#      @hsh = {}
#      @hsh[:crop] = crop_name
#      @avg_harvest_weight = @harvested_flats.where(crop: crop_name).average(:seed_weight_oz)
#      @hsh[:avg_opf] = @avg_harvest_weight
#      @harvest_avgs << @hsh
#    }

  end

  def back_of_envelope
    @harvested_flats = SeedFlat.where.not(harvest_weight_oz: 0.0).where.not(harvest_weight_oz: nil)
    @excluded_crops = ["corn","pea + sunflower","spicy mix"]
    @crops = @harvested_flats.pluck(:crop).uniq
    @excluded_crops.each{|junkcrop|
      @crops.reject!{|crop| crop == junkcrop }
    }
    
    ## avg yield per seed weight
    @cilantro = []
    SeedFlat.where(crop: "cilantro").group_by{ |flat| flat.seed_weight_oz }.sort_by{ |a,b| a }.each{ |a,b|
      @avg = b.map{|flat| flat.harvest_weight_oz}.reject{|val| val == nil}.inject{|sum,num| sum + num }.to_f / b.map{|flat| flat.harvest_weight_oz}.size
      @cilantro << [a,@avg]
    }

    @data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    @data_table.new_column('number', 'Seed Weight' )
    @data_table.new_column('number', 'Avg Yield')

    # Add Rows and Values
    @data_table.add_rows( @cilantro )

    @option = { width: '100%', height: 1200, title: 'Cilantro yield per seed weight' }
    @linechart = GoogleVisualr::Interactive::LineChart.new(@data_table, @option)
    @columnchart = GoogleVisualr::Interactive::ColumnChart.new(@data_table, @option)



    ## Monthly Flats Harvested Per Crop
    @flats_per_month = @harvested_flats.group_by{|flat| flat.harvested_on.month}
  end

  def aggregates
    # Get all harvested seed flats since Oct 1, 2018
    @query_cutoff_date =  (Date.today - 90) # "Mon, 01 Oct 2018"
    @harvested_flats = SeedFlat.where("started_date >= :date", date: @query_cutoff_date).where.not(harvest_weight_oz: 0.0).where.not(harvest_weight_oz: nil)
    #@crops_w_variety = Crop.all.to_a.map{|crop| [crop.crop, crop.crop_variety] }
    @crops = Crop.all#.to_a
    #@harvested_flats.each{|flat|
    #  @crops << [Crop.where(crop: flat.crop_id)[0].crop, Crop.where(crop: flat.crop_id)[0].crop_variety]
    #}

    @start_date = Date.new(2018,01,01)
    @week_start_dates = [@start_date]
    until Date.today - @start_date < 0
      @week_start_dates << @start_date += 7
    end

    @month_start_dates = [@start_date.at_beginning_of_month]
    until Date.today - @start_date < 0
      @month_start_dates << @start_date = @start_date.at_beginning_of_month.next_month
    end

  end

  def averages
    @harvested_flats = SeedFlat.where.not(harvest_weight_oz: nil).where.not(harvest_weight_oz: 0).group_by{|flat| flat.crop_id }.reject{|crop_group| crop_group == nil }.sort_by{|crop_group| Crop.where(id: crop_group[0])[0].crop }
    @today = Date.today
    @three_weeks_ago = @today - 21
    @three_months_ago = @today - 91
    @six_months_ago = @today - 182
    @nine_months_ago = @today - 274
    @twelve_months_ago = @today - 366
  end

  def yield_per_seed_weight
    @harvested_flats = SeedFlat.where.not(harvest_weight_oz: nil).where.not(harvest_weight_oz: 0).group_by{|flat| flat.crop_id }.reject{|crop_group| crop_group == nil }.sort_by{|crop_group| Crop.where(id: crop_group[0])[0].crop }
    #@past_three_week = @harvested_flats.select{|flat| ((Date.today-21)..Date.today).include? flat.harvested_on }
    #@past_three_months = @harvested_flats.select{|flat| ((Date.today-60)..Date.today).include? flat.harvested_on }
  end

  def yield_per_dth
    @harvested_flats = SeedFlat.where.not(harvest_weight_oz: nil).where.not(harvest_weight_oz: 0).group_by{|flat| flat.crop_id }.reject{|crop_group| crop_group == nil }.sort_by{|crop_group| Crop.where(id: crop_group[0])[0].crop }
  end

  def crop_availability
    @crops = SeedFlat.all.pluck(:crop).uniq
    @crops_from_crops_table = Crop.all#.to_a
  end

  def flat_allocation
    @allocated_flats = SeedFlat.all.where(harvest_weight_oz: nil).where.not(sewn_for: nil).reject{|flat| flat.sewn_for.length < 2 }.group_by{|flat| flat.sewn_for}
  end

  def crop_menu
  end

  def labels
    @disable_nav = true
    @crops = Crop.all
  end

end
