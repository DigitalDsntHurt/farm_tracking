class DashboardsController < ApplicationController
  def calendar
  	@today = Date.today
  	@seed_flats = SeedFlat.all
  	@grouped_seed_flats = SeedFlat.all.group_by{ |flat| flat.started_date }
  end

  def pipeline
	@propagation_shelf = SeedFlat.where(:date_of_first_transplant => nil)
  	@sue_shelf = SeedFlat.where.not(:date_of_first_transplant => nil).where(:date_of_second_transplant => nil).where(:harvested_on => nil)
  	@david_shelf = SeedFlat.where.not(:date_of_second_transplant => nil).where(:harvested_on => nil)
  end

  def calculator
  end
end
