class SeedTreatmentsController < ApplicationController
  before_action :set_seed_treatment, only: [:show, :edit, :update, :destroy]

  # GET /seed_treatments
  # GET /seed_treatments.json
  def index
    @seed_treatments = SeedTreatment.all.order(soak_start_datetime: :desc)

    @query_cutoff_date = "Mon, 01 Oct 2018"
    @crops = @seed_treatments.pluck(:seed_crop).uniq
  end

  def fresh_index
    @seed_treatments = SeedTreatment.all.where.not(date_of_first_flat_sew: nil).where(date_of_last_flat_sew: nil).where(killed_on: nil).order(soak_start_datetime: :desc)
    @query_cutoff_date = "Mon, 01 Oct 2018"
    @crops = @seed_treatments.pluck(:seed_crop).uniq
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
      if @seed_treatment.update(seed_treatment_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seed_treatment
      @seed_treatment = SeedTreatment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seed_treatment_params
      params.require(:seed_treatment).permit(:soak_start_datetime, :seed_crop, :seed_variety, :seed_brand, :seed_quantity_oz, :soak_solution, :soak_duration_hrs, :post_soak_treatment, :soak_notes, :germination_start_date, :germination_vehicle, :first_emerge_date, :full_emerge_date, :days_to_full_emergence, :emergence_notes, :killed_on, :planned_date_of_first_flat_sew, :date_of_first_flat_sew, :date_of_last_flat_sew, :destination_flat_ids, :finished)
    end
end
