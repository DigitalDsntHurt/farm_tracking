class SeedFlatsController < ApplicationController
  before_action :set_seed_flat, only: [:show, :edit, :update, :destroy]

  # GET /seed_flats
  # GET /seed_flats.json
  def index
    @seed_flats = SeedFlat.all.order(updated_at: :desc).take(750)
  end

  def basic_index
    @seed_flats = SeedFlat.all.where.not(crop_id: nil).order(updated_at: :desc)
  end

  def live_index
    @seed_flats = SeedFlat.all.where(harvest_weight_oz: nil).order(updated_at: :desc)
  end

  def harvested_index
    @seed_flats = SeedFlat.all.where.not(harvest_weight_oz: nil).where.not(harvest_weight_oz: 0).where.not(crop_id: nil).order(updated_at: :desc)
  end

  def killed_index
    @seed_flats = SeedFlat.all.where(harvest_weight_oz: 0).order(updated_at: :desc)
  end

  def harvested_killed
    @seed_flats = SeedFlat.all.where.not(harvest_weight_oz: nil).order(updated_at: :desc)
  end



  # GET /seed_flats/1
  # GET /seed_flats/1.json
  def show
  end

  # GET /seed_flats/new
  def new
    @seed_flat = SeedFlat.new
  end

  def new_prepopulated
    @customer_id = params[:customer_id]
    @crop_id = params[:crop_id]
    @seed_weight = Crop.where(id: params[:crop_id])[0].ideal_sew_seed_oz_per_flat
    @seed_flat = SeedFlat.new(crop_id: @crop_id, customer_id: @customer_id, seed_weight_oz: @seed_weight)
  end

  def new_treated_seed_flat
    @seed_treatment_id = params[:seed_treatment]
    @seed_treatment_object = SeedTreatment.where(id: @seed_treatment_id)[0]
    
    @seed_flat = SeedFlat.new
    @seed_flat.update(:crop_id => @seed_treatment_object.crop_id, :crop => @seed_treatment_object.seed_crop, :crop_variety => @seed_treatment_object.seed_variety, :seed_brand => @seed_treatment_object.seed_brand, :seed_treatments_id => @seed_treatment_id, :first_emerge_date => @seed_treatment_object.first_emerge_date, :full_emerge_date => @seed_treatment_object.full_emerge_date, :seed_media_treatment_notes => @seed_treatment_object.soak_notes, :emergence_notes => @seed_treatment_object.emergence_notes )
  end

  def create
    @seed_flat = SeedFlat.new(seed_flat_params)

    respond_to do |format|
      if @seed_flat.save
        format.html { redirect_to @seed_flat, notice: 'Seed flat was successfully created.' }
        format.json { render :show, status: :created, location: @seed_flat }
      else
        format.html { render :new }
        format.json { render json: @seed_flat.errors, status: :unprocessable_entity }
      end
    end
  end  

  def bulk_create
    ## this runs on a virgin form
    if params[:flat_ids] == nil
      @info = params[:info]
      @orders = params[:orders]#.split(",").map{|id| id.to_i }
    end

    ## this runs on form submit
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
        redirect_to seed_flats_bulk_create_error_path(problems: @problems)
      else # If all is well
        @flats_per_customer = Hash.new(0)
        
        # create a flats per customer hash
        params[:order_ids].split(",").each{|order_id|
          @order = Order.where(id: order_id)[0]
          @num_flats = SewSchedule.get_sew_quantity(@order)
          @customer = Customer.where(id: @order.customer_id)[0]

          @flats_per_customer[@customer.id] += @num_flats
        }

        # store all flat ids in a separate variable
        @new_flat_ids = params[:flat_ids].split(",")

        @flats_to_create = []

        # iterate through the flats per customer hash
        @flats_per_customer.sort_by{|k,v| v }.each{|arr|
          arr[1].times do
            @hsh = {flat_id: @new_flat_ids[0], customer_id: arr[0], crop_id: @order.crop_id, started_date: Date.today, medium: Crop.where(id: @order.crop_id)[0].default_medium, format: "matt", seed_weight_oz: Crop.where(id: @order.crop_id)[0].ideal_sew_seed_oz_per_flat, current_system_id: 3}
            @flats_to_create << @hsh
            @new_flat_ids.shift
          end
        }

        # handles sewing extra flats
        if @new_flat_ids.count > 0
          until @new_flat_ids.count == 0
            @hsh = {flat_id: @new_flat_ids[0], customer_id: 1, crop_id: @order.crop_id, started_date: Date.today, medium: Crop.where(id: @order.crop_id)[0].default_medium, format: "matt", seed_weight_oz: Crop.where(id: @order.crop_id)[0].ideal_sew_seed_oz_per_flat, current_system_id: 3}
            @flats_to_create << @hsh
            @new_flat_ids.shift
          end
        end

        # ditch unsewn flats
        @flats_to_create.reject!{|hsh| hsh[:flat_id] == nil }

        # create SeedFlats
        @new_flats = []
        @flats_to_create.each{|hsh|
          @flat = SeedFlat.new(hsh)
          @flat.save
          @new_flats << @flat
        }

        # count over-sews and under-sews
        @planned_allocation = @flats_per_customer.values.inject{|flat,sum| flat + sum }
        @actual_allocation = @new_flats.count
        @flat_diff = @actual_allocation - @planned_allocation

        redirect_to seed_flats_bulk_create_conf_path(new_flats: @new_flats, flat_diff: @flat_diff)
      end
    end
  end

  def bulk_create_error
    @problems = params[:problems]
  end

  def bulk_create_conf
    @created_flats = params[:new_flats]
    @flat_diff = params[:flat_diff].to_i
  end

  def edit
  end  

  def update
    respond_to do |format|
      if @seed_flat.update(seed_flat_params)
        format.html { redirect_to @seed_flat, notice: 'Seed flat was successfully updated.' }
        format.json { render :show, status: :ok, location: @seed_flat }
      else
        format.html { render :edit }
        format.json { render json: @seed_flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seed_flats/1
  # DELETE /seed_flats/1.json
  def destroy
    @seed_flat.destroy
    respond_to do |format|
      format.html { redirect_to seed_flats_basic_index_path, notice: 'Seed flat was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  def copy
    @seed_flat = SeedFlat.find(params[:old_seed_flat]).dup
    render new_seed_flat_path(@seed_flat)
  end

  def copy_treated_seed_flat
    @seed_flat = SeedFlat.find(params[:old_seed_flat]).dup
    render seed_flats_new_treated_seed_flat_path(@seed_flat)
  end

  def first_emerge
    @seed_flat = SeedFlat.find(params[:flat])
    @seed_flat.update(:first_emerge_date => Date.today)
    redirect_back(fallback_location: root_path) #redirect_to action: "index"
  end

  def full_emerge
    @seed_flat = SeedFlat.find(params[:flat])
    @seed_flat.update(:full_emerge_date => Date.today)
    redirect_back(fallback_location: root_path)  #redirect_to action: "index"
  end

  def cascade_full_emerge
    @seed_flat = SeedFlat.find(params[:flat])
    @date_diff = (Date.today - @seed_flat.started_date).to_i
    
    if @date_diff == 0
      @seed_flat.update(first_emerge_date: Date.today, full_emerge_date: Date.today)
    elsif @date_diff == 1
      @seed_flat.update(first_emerge_date: (Date.today-1), full_emerge_date: Date.today)
    else
      @seed_flat.update(first_emerge_date: Date.today-(@date_diff/2.0), full_emerge_date: Date.today)
    end

    redirect_back(fallback_location: root_path)  #redirect_to action: "index"
  end

  def first_transplant
    @seed_flat = SeedFlat.find(params[:flat])
    @seed_flat.update(:date_of_first_transplant => Date.today)
    redirect_back(fallback_location: root_path)  #redirect_to action: "index"
  end

  def second_transplant
    @seed_flat = SeedFlat.find(params[:flat])
    @seed_flat.update(:date_of_second_transplant => Date.today)
    redirect_back(fallback_location: root_path) #redirect_to :back #action: "index"
  end

  def third_transplant
    @seed_flat = SeedFlat.find(params[:flat])
    @seed_flat.update(:date_of_third_transplant => Date.today)
    redirect_back(fallback_location: root_path) #redirect_to action: "index"
  end

  def harvest
    @seed_flat = SeedFlat.find(params[:flat])
  end

  def kill
    @seed_flat = SeedFlat.find(params[:flat])
    @seed_flat.update(:harvest_weight_oz => 0.0)
    redirect_back(fallback_location: :index)
  end

  def new_treated_seed_flat
    @seed_treatment_id = params[:seed_treatment]
    @seed_treatment_object = SeedTreatment.where(id: @seed_treatment_id)[0]
    
    @seed_flat = SeedFlat.new
    @seed_flat.update(:crop_id => @seed_treatment_object.crop_id, :crop => @seed_treatment_object.seed_crop, :crop_variety => @seed_treatment_object.seed_variety, :seed_brand => @seed_treatment_object.seed_brand, :seed_treatments_id => @seed_treatment_id, :first_emerge_date => @seed_treatment_object.first_emerge_date, :full_emerge_date => @seed_treatment_object.full_emerge_date, :seed_media_treatment_notes => @seed_treatment_object.soak_notes, :emergence_notes => @seed_treatment_object.emergence_notes )
  end

  def bulk_actions
    unless params[:flat_ids] == nil
      if params[:commit] == "Mark First Emerged"
        params[:flat_ids].each{|id|
          SeedFlat.where(id: id).update(first_emerge_date: Date.today)
        }
      elsif params[:commit] == "Mark Full Emerged"
        params[:flat_ids].each{|id|
          SeedFlat.where(id: id).update(full_emerge_date: Date.today)
        }
      elsif params[:commit] == "Mark Cascade Full Emerged"
        params[:flat_ids].each{|id|
          @seed_flat = SeedFlat.where(id: id)
          @date_diff = (Date.today - @seed_flat[0].started_date).to_i
          if @date_diff == 0
            @seed_flat.update(first_emerge_date: Date.today, full_emerge_date: Date.today)
          elsif @date_diff == 1
            @seed_flat.update(first_emerge_date: (Date.today-1), full_emerge_date: Date.today)
          else
            @seed_flat.update(first_emerge_date: Date.today-(@date_diff/2.0), full_emerge_date: Date.today)
          end
        }
      elsif params[:commit] == "Kill"
        params[:flat_ids].each{|id|
          SeedFlat.where(id: id).update(harvest_weight_oz: 0)
        }
      elsif params[:commit].include?("~>")
        params[:flat_ids].each{|id|
          @seed_flat = SeedFlat.where(id: id)[0]
          @origin_system_id = @seed_flat.current_system_id
          @destination_system_id = System.where(system_name: params[:commit].gsub("~>",""))[0].id
          @seed_flat_update = SeedFlatUpdate.new
          @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
        }        
      else 

      end
    end
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seed_flat
      @seed_flat = SeedFlat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seed_flat_params
      params.require(:seed_flat).permit(:started_date, :flat_id, :crop, :crop_variety, :seed_brand, :medium, :format, :seed_weight_oz, :seed_media_treatment_notes, :first_emerge_date, :full_emerge_date, :emergence_notes, :date_of_first_transplant, :date_of_second_transplant, :date_of_third_transplant, :harvested_on, :harvest_weight_oz, :hrvst_wt_lbs, :harvest_week, :harvest_notes, :former_flat_id, :seed_treatments_id, :room_id, :current_system_id, :exclude_from_freshlist, :force_onto_freshlist, :sewn_for, :crop_id, :customer_id, :harvested_for, :total_dth, :treatment_days, :propagation_days, :system_days)
    end
end
