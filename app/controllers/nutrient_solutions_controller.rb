class NutrientSolutionsController < ApplicationController
  before_action :set_nutrient_solution, only: [:show, :edit, :update, :destroy]

  # GET /nutrient_solutions
  # GET /nutrient_solutions.json
  def index
    @nutrient_solutions = NutrientSolution.all.order(date_mixed: :desc, updated_at: :desc)
  end

  # GET /nutrient_solutions/1
  # GET /nutrient_solutions/1.json
  def show
  end

  # GET /nutrient_solutions/new
  def new
    @nutrient_solution = NutrientSolution.new
  end

  # GET /nutrient_solutions/1/edit
  def edit
  end

  # POST /nutrient_solutions
  # POST /nutrient_solutions.json
  def create
    @nutrient_solution = NutrientSolution.new(nutrient_solution_params)

    respond_to do |format|
      if @nutrient_solution.save
        format.html { redirect_to @nutrient_solution, notice: 'Nutrient solution was successfully created.' }
        format.json { render :show, status: :created, location: @nutrient_solution }
      else
        format.html { render :new }
        format.json { render json: @nutrient_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nutrient_solutions/1
  # PATCH/PUT /nutrient_solutions/1.json
  def update
    respond_to do |format|
      if @nutrient_solution.update(nutrient_solution_params)
        format.html { redirect_to @nutrient_solution, notice: 'Nutrient solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @nutrient_solution }
      else
        format.html { render :edit }
        format.json { render json: @nutrient_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nutrient_solutions/1
  # DELETE /nutrient_solutions/1.json
  def destroy
    @nutrient_solution.destroy
    respond_to do |format|
      format.html { redirect_to nutrient_solutions_url, notice: 'Nutrient solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nutrient_solution
      @nutrient_solution = NutrientSolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nutrient_solution_params
      params.require(:nutrient_solution).permit(:date_mixed, :reservoir_id, :system, :reservoir_fill_volume_liters, :topup_or_reset, :ingredient1, :ingredient1_qty_ml, :ingredient2, :ingredient2_qty_ml, :ingredient3, :ingredient3_qty_ml, :ingredient4, :ingredient4_qty_ml, :ingredient5, :ingredient5_qty_ml, :ingredient6, :ingredient6_qty_ml, :ingredient7, :ingredient7_qty_ml, :ingredient8, :ingredient8_qty_ml, :ingredient9, :ingredient9_qty_ml, :ingredient10, :ingredient10_qty_ml)
    end
end
