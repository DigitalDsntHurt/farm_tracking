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

  def bulk_flat_form
    @info = params[:info]
    @new_info = params[:new_info]
    @crop_id = params[:crop_id]
    @customer_id = params[:customer_id]
    @treatment = params[:treatment]
    @customer_flats = params[:customer_flats].map{|num| num[0].to_i }.flatten.in_groups_of(2)

    
    ## After form is submitted
    @new_flats = []
    @problem_flats = []
    if params[:flat_ids] != nil
      ## Check for problems
      @problems = []
      @flats = params[:flat_ids].gsub(" ","").gsub(", ",",").split(",").each{|flat_id| 
        @flat_identifier = flat_id.upcase
        @test_flat = SeedFlat.where(flat_id: @flat_identifier)
        if @test_flat.exists?
          @problems << @flat_identifier
        end
      }

      # If a problem exists
      if @problems.count > 0
        redirect_to dashboards_bulk_form_error_path(problems: @problems)
      # If all is well
      else
        @flat_ids_to_use = params[:flat_ids].gsub(", ",",").split(",")

        counter = 0
        @customer_flats.each{|pair|
          
          pair[1].times do 
            flat_id_to_use = @flat_ids_to_use[counter]

            if SeedFlat.where(flat_id: flat_id_to_use).count != 0
              @problem_flats << id
            else
              @flat = SeedFlat.new(started_date: Date.today, medium: params[:medium], format: params[:format], seed_weight_oz: params[:seed_weight], flat_id: flat_id_to_use, current_system_id: params[:current_system_id], crop_id: params[:crop_id], customer_id: pair[0], seed_treatments_id: @treatment)
              @flat.save
              @new_flats << @flat
            end
            counter += 1
          end

        }     
        redirect_to dashboards_bulk_form_conf_path(new_flats: @new_flats)        
      end
    end
  end

end
