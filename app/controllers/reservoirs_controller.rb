class ReservoirsController < ApplicationController
  before_action :set_reservoir, only: [:show, :edit, :update, :destroy]

  # GET /reservoirs
  # GET /reservoirs.json
  def index
    @reservoirs = Reservoir.all
  end

  # GET /reservoirs/1
  # GET /reservoirs/1.json
  def show
  end

  # GET /reservoirs/new
  def new
    @reservoir = Reservoir.new
  end

  # GET /reservoirs/1/edit
  def edit
  end

  # POST /reservoirs
  # POST /reservoirs.json
  def create
    @reservoir = Reservoir.new(reservoir_params)

    respond_to do |format|
      if @reservoir.save
        format.html { redirect_to @reservoir, notice: 'Reservoir was successfully created.' }
        format.json { render :show, status: :created, location: @reservoir }
      else
        format.html { render :new }
        format.json { render json: @reservoir.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservoirs/1
  # PATCH/PUT /reservoirs/1.json
  def update
    respond_to do |format|
      if @reservoir.update(reservoir_params)
        format.html { redirect_to @reservoir, notice: 'Reservoir was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservoir }
      else
        format.html { render :edit }
        format.json { render json: @reservoir.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservoirs/1
  # DELETE /reservoirs/1.json
  def destroy
    @reservoir.destroy
    respond_to do |format|
      format.html { redirect_to reservoirs_url, notice: 'Reservoir was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservoir
      @reservoir = Reservoir.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservoir_params
      params.require(:reservoir).permit(:name, :size_liters, :brand)
    end
end
