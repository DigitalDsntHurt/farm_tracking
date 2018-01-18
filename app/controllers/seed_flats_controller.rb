class SeedFlatsController < ApplicationController
  before_action :set_seed_flat, only: [:show, :edit, :update, :destroy]

  # GET /seed_flats
  # GET /seed_flats.json
  def index
    @seed_flats = SeedFlat.all
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
      format.html { redirect_to seed_flats_url, notice: 'Seed flat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def copy
    @seed_flat = SeedFlat.find(params[:old_seed_flat]).dup
    render new_seed_flat_path(@seed_flat)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seed_flat
      @seed_flat = SeedFlat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seed_flat_params
      params.require(:seed_flat).permit(:started_date, :flat_id, :crop, :crop_variety, :seed_brand, :medium, :format, :seed_weight, :seed_wt_units, :seed_media_treatment_notes, :first_emerge_date, :full_emerge_date, :emergence_notes, :date_of_first_transplant, :first_transplant_notes, :date_of_second_transplant, :second_transplant_notes, :harvested_on, :harvest_weight_oz, :hrvst_wt_lbs, :harvest_week, :harvest_notes)
    end
end
