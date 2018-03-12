class DashboardsController < ApplicationController
  def calendar
  	@today = Date.today
  	@seed_flats = SeedFlat.all
  	@grouped_seed_flats = SeedFlat.all.group_by{ |flat| flat.started_date }
  end

  def pipeline
    @propagation_shelf = SeedFlat.where(:date_of_first_transplant => nil).where(:harvest_weight_oz => nil)
    @sue_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where(:date_of_second_transplant => nil).where(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil)
    @david_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where.not(:date_of_second_transplant => nil).where(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil)
    @live_storage_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where.not(:date_of_second_transplant => nil).where.not(:date_of_third_transplant => nil).where(:harvest_weight_oz => nil)
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
  end
end
