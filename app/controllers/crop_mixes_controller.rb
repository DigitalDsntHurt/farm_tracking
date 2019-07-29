class CropMixesController < ApplicationController
  before_action :set_crop_mix, only: [:show, :edit, :update, :destroy]

  # GET /crop_mixes
  # GET /crop_mixes.json
  def index
    @crop_mixes = CropMix.all
  end

  # GET /crop_mixes/1
  # GET /crop_mixes/1.json
  def show
  end

  # GET /crop_mixes/new
  def new
    @crop_mix = CropMix.new
  end

  # GET /crop_mixes/1/edit
  def edit
  end

  # POST /crop_mixes
  # POST /crop_mixes.json
  def create
    @crop_mix = CropMix.new(crop_mix_params)

    respond_to do |format|
      if @crop_mix.save
        format.html { redirect_to @crop_mix, notice: 'Crop mix was successfully created.' }
        format.json { render :show, status: :created, location: @crop_mix }
      else
        format.html { render :new }
        format.json { render json: @crop_mix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crop_mixes/1
  # PATCH/PUT /crop_mixes/1.json
  def update
    respond_to do |format|
      if @crop_mix.update(crop_mix_params)
        format.html { redirect_to @crop_mix, notice: 'Crop mix was successfully updated.' }
        format.json { render :show, status: :ok, location: @crop_mix }
      else
        format.html { render :edit }
        format.json { render json: @crop_mix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crop_mixes/1
  # DELETE /crop_mixes/1.json
  def destroy
    @crop_mix.destroy
    respond_to do |format|
      format.html { redirect_to crop_mixes_url, notice: 'Crop mix was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crop_mix
      @crop_mix = CropMix.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crop_mix_params
      params.require(:crop_mix).permit(:name, :crop_one_id, :crop_one_parts, :crop_two_id, :crop_two_parts, :crop_three_id, :crop_three_parts, :crop_four_id, :crop_four_parts, :crop_five_id, :crop_five_parts, :crop_six_id, :crop_six_parts, :crop_seven_id, :crop_seven_parts, :crop_eight_id, :crop_eight_parts)
    end
end
