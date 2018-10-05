class DashboardsController < ApplicationController
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

  def old_pipeline
    @propagation_shelf = SeedFlat.where(:date_of_first_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
    @sue_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where(:date_of_second_transplant => nil).where(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
    @david_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where.not(:date_of_second_transplant => nil).where(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
    @live_storage_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where.not(:date_of_second_transplant => nil).where.not(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil).order(started_date: :desc, updated_at: :desc)
  end

  def pipeline
    @propagation_system_ids = System.all.where(system_name: "propagation").to_a.map{|s| s.id}
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
    SeedFlat.where(crop: "cilantro").group_by{ |flat| flat.seed_weight }.sort_by{ |a,b| a }.each{ |a,b|
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
  end

  def crop_menu
  end


  def scratch
  end
end
