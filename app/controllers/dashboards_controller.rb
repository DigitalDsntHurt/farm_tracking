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
  
    # only calculate for those crops with data
    @crops = SeedFlat.where.not(harvested_on: nil).pluck(:crop).uniq

  end

  def calculate
    #@result = HarvestCalculator.send(params[:crop], params[:weight])
    @result = HarvestCalculator.send(:hc, *[params[:dashboards][:crop], params[:weight], params[:date]])
    
    @crops = SeedFlat.pluck(:crop).uniq
    render :calculator
  end


end
