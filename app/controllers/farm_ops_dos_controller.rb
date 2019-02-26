class FarmOpsDosController < ApplicationController
  before_action :set_farm_ops_do, only: [:show, :edit, :update, :destroy]

  # GET /farm_ops_dos
  # GET /farm_ops_dos.json
  def index
    @farm_ops_dos = FarmOpsDo.all
  end

  # GET /farm_ops_dos/1
  # GET /farm_ops_dos/1.json
  def show
  end

  # GET /farm_ops_dos/new
  def new
    @farm_ops_do = FarmOpsDo.new
  end

  # GET /farm_ops_dos/1/edit
  def edit
  end

  # POST /farm_ops_dos
  # POST /farm_ops_dos.json
  def create
    @farm_ops_do = FarmOpsDo.new(farm_ops_do_params)

    respond_to do |format|
      if @farm_ops_do.save
        format.html { redirect_to @farm_ops_do, notice: 'Farm ops do was successfully created.' }
        format.json { render :show, status: :created, location: @farm_ops_do }
      else
        format.html { render :new }
        format.json { render json: @farm_ops_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /farm_ops_dos/1
  # PATCH/PUT /farm_ops_dos/1.json
  def update
    respond_to do |format|
      if @farm_ops_do.update(farm_ops_do_params)
        format.html { redirect_to @farm_ops_do, notice: 'Farm ops do was successfully updated.' }
        format.json { render :show, status: :ok, location: @farm_ops_do }
      else
        format.html { render :edit }
        format.json { render json: @farm_ops_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /farm_ops_dos/1
  # DELETE /farm_ops_dos/1.json
  def destroy
    @farm_ops_do.destroy
    respond_to do |format|
      format.html { redirect_to farm_ops_dos_url, notice: 'Farm ops do was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farm_ops_do
      @farm_ops_do = FarmOpsDo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def farm_ops_do_params
      params.require(:farm_ops_do).permit(:verb, :date, :crop, :variety, :customer)
    end
end
