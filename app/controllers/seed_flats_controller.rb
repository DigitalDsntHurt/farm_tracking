class SeedFlatsController < ApplicationController
  before_action :set_seed_flat, only: [:show, :edit, :update, :destroy]

  # GET /seed_flats
  # GET /seed_flats.json
  def index
    @seed_flats = SeedFlat.all.order(updated_at: :desc)
  end

  def basic_index
    @seed_flats = SeedFlat.all.order(updated_at: :desc)
  end

  def live_index
    @seed_flats = SeedFlat.all.where(harvest_weight_oz: nil).order(updated_at: :desc)
  end

  def harvested_index
    @seed_flats = SeedFlat.all.where.not(harvest_weight_oz: nil).where.not(harvest_weight_oz: 0).order(updated_at: :desc)
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

  # GET /seed_flats/1/edit
  def edit
  end

  # POST /seed_flats
  # POST /seed_flats.json
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

  def new_treated_seed_flat
    @seed_treatment_id = params[:seed_treatment]
    @seed_treatment_object = SeedTreatment.where(id: @seed_treatment_id)[0]
    
    @seed_flat = SeedFlat.new
    @seed_flat.update(:crop_id => @seed_treatment_object.crop_id, :crop => @seed_treatment_object.seed_crop, :crop_variety => @seed_treatment_object.seed_variety, :seed_brand => @seed_treatment_object.seed_brand, :seed_treatments_id => @seed_treatment_id, :first_emerge_date => @seed_treatment_object.first_emerge_date, :full_emerge_date => @seed_treatment_object.full_emerge_date, :seed_media_treatment_notes => @seed_treatment_object.soak_notes, :emergence_notes => @seed_treatment_object.emergence_notes )
  end  

#  def new_treated_seed_flat_from_ops_cal
#    @seed_treatment_id = params[:seed_treatment]
#    @seed_treatment_object = SeedTreatment.where(id: @seed_treatment_id)[0]
    
#   @seed_flat = SeedFlat.new
#    @seed_flat.update(:crop_id => @seed_treatment_object.crop_id, :seed_treatments_id => @seed_treatment_id, :first_emerge_date => @seed_treatment_object.first_emerge_date, :full_emerge_date => @seed_treatment_object.full_emerge_date )
#  end  

  # PATCH/PUT /seed_flats/1
  # PATCH/PUT /seed_flats/1.json
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
    redirect_to action: "index"
  end

  def new_treated_seed_flat
    @seed_treatment_id = params[:seed_treatment]
    @seed_treatment_object = SeedTreatment.where(id: @seed_treatment_id)[0]
    
    @seed_flat = SeedFlat.new
    @seed_flat.update(:crop_id => @seed_treatment_object.crop_id, :crop => @seed_treatment_object.seed_crop, :crop_variety => @seed_treatment_object.seed_variety, :seed_brand => @seed_treatment_object.seed_brand, :seed_treatments_id => @seed_treatment_id, :first_emerge_date => @seed_treatment_object.first_emerge_date, :full_emerge_date => @seed_treatment_object.full_emerge_date, :seed_media_treatment_notes => @seed_treatment_object.soak_notes, :emergence_notes => @seed_treatment_object.emergence_notes )
    
    #@seed_treatment_object.update(:destination_flat_ids => @seed_flat.id)

    #render new_seed_flat_path(@seed_flat)
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
      params.require(:seed_flat).permit(:started_date, :flat_id, :crop, :crop_variety, :seed_brand, :medium, :format, :seed_weight_oz, :seed_media_treatment_notes, :first_emerge_date, :full_emerge_date, :emergence_notes, :date_of_first_transplant, :date_of_second_transplant, :date_of_third_transplant, :harvested_on, :harvest_weight_oz, :hrvst_wt_lbs, :harvest_week, :harvest_notes, :former_flat_id, :seed_treatments_id, :room_id, :current_system_id, :exclude_from_freshlist, :force_onto_freshlist, :sewn_for, :crop_id, :customer_id)
    end
end
