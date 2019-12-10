class CropsController < ApplicationController
  before_action :set_crop, only: [:show, :edit, :update, :destroy]

  # GET /crops
  # GET /crops.json
  def index
    @crops = Crop.all.order(:crop)
  end

  def crop_ref
    @crops = Crop.all.order(:crop)
  end

  # GET /crops/1
  # GET /crops/1.json
  def show
  end

  # GET /crops/new
  def new
    @crop = Crop.new
  end

  # GET /crops/1/edit
  def edit
  end

  # POST /crops
  # POST /crops.json
  def create
    @crop = Crop.new(crop_params)

    respond_to do |format|
      if @crop.save
        format.html { redirect_to @crop, notice: 'Crop was successfully created.' }
        format.json { render :show, status: :created, location: @crop }
      else
        format.html { render :new }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  def clone
    @crop = Crop.find(params[:order]).dup
    render new_crop_path(@crop)
  end

  # PATCH/PUT /crops/1
  # PATCH/PUT /crops/1.json
  def update
    respond_to do |format|
      if @crop.update(crop_params)
        format.html { redirect_to @crop, notice: 'Crop was successfully updated.' }
        format.json { render :show, status: :ok, location: @crop }
      else
        format.html { render :edit }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.json
  def destroy
    @crop.destroy
    respond_to do |format|
      format.html { redirect_to crops_url, notice: 'Crop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crop
      @crop = Crop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crop_params
      params.require(:crop).permit(:crop, :crop_variety, :seed_treatment, :avg_seed_treatment_duration_days, :ideal_seed_treatment_duration_days, :calculated_seed_oz_to_soak_per_desired_flat, :ideal_seed_oz_to_soak_per_desired_flat, :avg_alltime_seed_oz_per_flat, :avg_6month_seed_oz_per_flat, :avg_6week_seed_oz_per_flat, :ideal_seed_oz_per_flat, :avg_days_to_first_transplant, :ideal_days_to_first_transplant, :avg_alltime_days_to_harvest, :avg_6month_days_to_harvest, :avg_6week_days_to_harvest, :ideal_days_to_harvest, :avg_alltime_yield_per_flat_oz, :avg_6month_yield_per_flat_oz, :avg_6week_yield_per_flat_oz, :sale_price_per_oz, :sale_price_per_8oz, :sale_price_per_16oz, :sale_price_per_live_flat, :ideal_treatment_days, :avg_treatment_days, :ideal_propagation_days, :avg_propagation_days, :ideal_system_days, :avg_system_days, :ideal_post_treatment_dth, :avg_post_treatment_dth, :ideal_total_dth, :avg_total_dth, :ideal_soak_seed_oz_per_flat, :avg_soak_seed_oz_per_flat, :ideal_sew_seed_oz_per_flat, :avg_sew_seed_oz_per_flat, :avg_yield_per_flat_oz, :seed_supplier, :ideal_yield_per_flat_oz, :crop_type, :default_medium)
    end
end
