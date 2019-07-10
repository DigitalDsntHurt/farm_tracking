class MediaUnitCostsController < ApplicationController
  before_action :set_media_unit_cost, only: [:show, :edit, :update, :destroy]

  # GET /media_unit_costs
  # GET /media_unit_costs.json
  def index
    @media_unit_costs = MediaUnitCost.all.order(date: :desc)
    # get week start dates
    @start_date = Date.new(2019,07,01)
    @week_start_dates = [@start_date]
    until Date.today - @start_date < 0
      @week_start_dates << @start_date += 7
    end
  end

  # GET /media_unit_costs/1
  # GET /media_unit_costs/1.json
  def show
  end

  # GET /media_unit_costs/new
  def new
    @media_unit_cost = MediaUnitCost.new
  end

  # GET /media_unit_costs/1/edit
  def edit
  end

  # POST /media_unit_costs
  # POST /media_unit_costs.json
  def create
    @media_unit_cost = MediaUnitCost.new(media_unit_cost_params)

    respond_to do |format|
      if @media_unit_cost.save
        format.html { redirect_to media_unit_costs_path, notice: 'Media unit cost was successfully created.' }
        format.json { render :show, status: :created, location: @media_unit_cost }
      else
        format.html { render :new }
        format.json { render json: @media_unit_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_unit_costs/1
  # PATCH/PUT /media_unit_costs/1.json
  def update
    respond_to do |format|
      if @media_unit_cost.update(media_unit_cost_params)
        format.html { redirect_to media_unit_costs_path, notice: 'Media unit cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_unit_cost }
      else
        format.html { render :edit }
        format.json { render json: @media_unit_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_unit_costs/1
  # DELETE /media_unit_costs/1.json
  def destroy
    @media_unit_cost.destroy
    respond_to do |format|
      format.html { redirect_to media_unit_costs_url, notice: 'Media unit cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_unit_cost
      @media_unit_cost = MediaUnitCost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_unit_cost_params
      params.require(:media_unit_cost).permit(:date, :media, :unit_cost, :notes)
    end
end
