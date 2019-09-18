class ToolsController < ApplicationController
  
  def crop_availability
  	@crops_from_crops_table = Crop.all.sort_by{|c| c.crop }
  	@active_flats = SeedFlat.where(harvest_weight_oz: nil).group_by{|flat| flat.crop_id }.map{|crop_group| ["#{Crop.where(id: crop_group[0])[0].crop.capitalize}, #{Crop.where(id: crop_group[0])[0].crop_variety}", crop_group[1].map{|flat| [flat, "#{flat.flat_id}", Customer.where(id: flat.customer_id)[0].name, System.where(id: flat.current_system_id)[0].system_name, (Date.today-flat.started_date).to_i, SeedFlatUpdate.where(update_type: "harvest").where(seed_flat_id: flat.id).count] }.sort_by!{|flat| flat[4] }.reverse] }.sort_by!{|crop_group| crop_group[0] }
  end

  def new_crop_avail
  	#@crops_from_crops_table = Crop.all.sort_by{|c| c.crop }
  	#@active_flats = SeedFlat.where(harvest_weight_oz: nil).group_by{|flat| flat.crop_id }.map{|crop_group| ["#{Crop.where(id: crop_group[0])[0].crop.capitalize}, #{Crop.where(id: crop_group[0])[0].crop_variety}", crop_group[1].count] }
  	@counts = SeedFlat.where(harvest_weight_oz: nil).where.not(current_system_id: 3).group_by{|flat| flat.crop_id }.map{|group| [group[0], "#{Crop.where(id: group[0])[0].crop.capitalize}, #{Crop.where(id: group[0])[0].crop_variety}" ,group[1].count] }.sort_by{|count_group| count_group[1] }
  end

  def single_crop_avail
  	@crop_id = params[:crop_id]
  	@active_flats = SeedFlat.where(crop_id: @crop_id).where(harvest_weight_oz: nil).where.not(current_system_id: 3).sort_by{|flat| (Date.today - flat.started_date).to_i }.reverse
  end

end
