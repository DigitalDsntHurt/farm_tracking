class SeedTreatmentsController < ApplicationController
  before_action :set_seed_treatment, only: [:show, :edit, :update, :destroy]

  # GET /seed_treatments
  # GET /seed_treatments.json
  def index
    @seed_treatments = SeedTreatment.all.order(soak_start_datetime: :desc)

    @query_cutoff_date = "Mon, 01 Oct 2018"
    @crops = @seed_treatments.pluck(:seed_crop).uniq
    @crops = @seed_treatments.pluck(:crop_id).map{|id| Crop.where(id: id)[0].crop }.uniq
  end

  def fresh_index
    @all_seed_treatments = SeedTreatment.all.order(soak_start_datetime: :desc)
    @live_seed_treatments = SeedTreatment.all.where(finished: false).where(killed_on: nil).order(soak_start_datetime: :desc)
    @query_cutoff_date = "Mon, 01 Oct 2018"
    @crops = @live_seed_treatments.pluck(:crop_id).map{|id| Crop.where(id: id)[0].crop }.uniq
  end

  # GET /seed_treatments/1
  # GET /seed_treatments/1.json
  def show
  end

  # GET /seed_treatments/new
  def new
    @seed_treatment = SeedTreatment.new
  end

  # GET /seed_treatments/1/edit
  def edit
  end

  # POST /seed_treatments
  # POST /seed_treatments.json
  def create
    @seed_treatment = SeedTreatment.new(seed_treatment_params)

    respond_to do |format|
      if @seed_treatment.save
        format.html { redirect_to @seed_treatment, notice: 'Seed treatment was successfully created.' }
        format.json { render :show, status: :created, location: @seed_treatment }
      else
        format.html { render :new }
        format.json { render json: @seed_treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seed_treatments/1
  # PATCH/PUT /seed_treatments/1.json
  def update
    respond_to do |format|
      if @seed_treatment.update(seed_treatment_params) and params[:commit] == "end soak"
        format.html { redirect_to seed_treatments_fresh_index_path, notice: 'Soak was successfully ended.' }
        format.json { render :show, status: :ok, location: @seed_treatment }
      elsif @seed_treatment.update(seed_treatment_params)
        format.html { redirect_to @seed_treatment, notice: 'Seed treatment was successfully updated.' }
        format.json { render :show, status: :ok, location: @seed_treatment }
      else
        format.html { render :edit }
        format.json { render json: @seed_treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  def clone
    @seed_treatment = SeedTreatment.find(params[:seed_treatment]).dup
    render new_seed_treatment_path(@seed_treatment)
  end

  def end_soak
    @seed_treatment = SeedTreatment.find(params[:seed_treatment])
    puts "======"
    puts "======"
    puts "======"
    puts @seed_treatment.save
    puts params[:commit]
    puts "======"
    puts "======"
    puts "======"
    #if @seed_treatment params[:commit] == "end soak"
    #  redirect_to seed_treatments_fresh_index_path
    #end
  end

  def first_emerge
    @seed_treatment = SeedTreatment.find(params[:seed_treatment])
    @seed_treatment.update(:first_emerge_date => Date.today)
    redirect_back(fallback_location: root_path)
  end

  def full_emerge
    @seed_treatment = SeedTreatment.find(params[:seed_treatment])
    @seed_treatment.update(:full_emerge_date => Date.today)
    redirect_back(fallback_location: root_path)
  end

  def cascade_full_emerge
    @seed_treatment = SeedTreatment.find(params[:seed_treatment])
    @date_diff = (Date.today - @seed_treatment.germination_start_date).to_i
    if @date_diff == 0
      @seed_treatment.update(first_emerge_date: Date.today, full_emerge_date: Date.today)
    elsif @date_diff == 1
      @seed_treatment.update(first_emerge_date: (Date.today-1), full_emerge_date: Date.today)
    else
      @seed_treatment.update(first_emerge_date: Date.today-(@date_diff/2.0), full_emerge_date: Date.today)
    end
    @seed_treatment.update(:full_emerge_date => Date.today)
    redirect_back(fallback_location: root_path)
  end

  def finish
    @seed_treatment = SeedTreatment.find(params[:seed_treatment])
    @seed_treatment.update(finished: true)
    redirect_back(fallback_location: root_path)
  end

  # DELETE /seed_treatments/1
  # DELETE /seed_treatments/1.json
  def destroy
    @seed_treatment.destroy
    respond_to do |format|
      format.html { redirect_to seed_treatments_url, notice: 'Seed treatment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def kill
    @seed_treatment_group = SeedTreatment.find(params[:seed_group])
    @seed_treatment_group.update(:killed_on => Date.today)
    redirect_to action: "index"
  end

  def new_assigned_seed_treatment
    #@order_ids = params[:order_ids]
    @order_dummies = params[:order_ids]
    @crop_id = params[:crop_id]
    @seed_quantity_oz = params[:qty]
    @seed_treatment = SeedTreatment.new(:order_dummies => @order_dummies.join(","), :crop_id => @crop_id, :seed_quantity_oz => @seed_quantity_oz)
    #@seed_treatment.update(:order_ids => @order_ids )
  end

  def bulk_soak_form
    @info = params[:info]
    @crop_id = params[:crop_id]
    @soak_qty = params[:soak_qty]
    @order_ids = params[:order_ids]
    @orders = params[:orders]

    @new_soak = []

    @seed_treatment = SeedTreatment.new(crop_id: @crop_id, seed_quantity_oz: @soak_qty, order_ids: @order_ids, orders: @orders)


    
    #if params[:flat_ids] != nil
    #  params[:flat_ids].gsub(", ",",").split(",").each{|id|
    #    @flat = SeedFlat.new(started_date: Date.today, medium: params[:medium], format: params[:format], seed_weight_oz: params[:seed_weight], flat_id: id, current_system_id: params[:current_system_id], crop_id: params[:crop_id], customer_id: params[:customer_id])
    #    @flat.save
    #    @new_flats << @flat
    #  }
    #  redirect_to dashboards_bulk_form_conf_path(new_flats: @new_flats)
    #end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seed_treatment
      @seed_treatment = SeedTreatment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seed_treatment_params
      params.require(:seed_treatment).permit(:soak_start_datetime, :seed_crop, :seed_variety, :seed_brand, :seed_quantity_oz, :soak_solution, :soak_duration_hrs, :post_soak_treatment, :soak_notes, :germination_start_date, :germination_vehicle, :first_emerge_date, :full_emerge_date, :days_to_full_emergence, :emergence_notes, :killed_on, :planned_date_of_first_flat_sew, :date_of_first_flat_sew, :date_of_last_flat_sew, :destination_flat_ids, :finished, :crop_id, :order_ids, :order_dummies, :orders)
    end
end
