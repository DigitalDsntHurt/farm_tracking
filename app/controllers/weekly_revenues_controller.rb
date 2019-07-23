class WeeklyRevenuesController < ApplicationController
  before_action :set_weekly_revenue, only: [:show, :edit, :update, :destroy]


  # GET /weekly_revenues
  # GET /weekly_revenues.json
  def index
    @weekly_revenues = WeeklyRevenue.all
  end

  # GET /weekly_revenues/1
  # GET /weekly_revenues/1.json
  def show
  end

  # GET /weekly_revenues/new
  def new
    @weekly_revenue = WeeklyRevenue.new
    @most_recent_monday = Date.today
    if @most_recent_monday.monday?
      #
    else
      until @most_recent_monday.monday?
        @most_recent_monday -= 1
      end
    end
  end

  # GET /weekly_revenues/1/edit
  def edit
  end

  # POST /weekly_revenues
  # POST /weekly_revenues.json
  def create
    @weekly_revenue = WeeklyRevenue.new(weekly_revenue_params)

    respond_to do |format|
      if @weekly_revenue.save
        format.html { redirect_to @weekly_revenue, notice: 'Weekly revenue was successfully created.' }
        format.json { render :show, status: :created, location: @weekly_revenue }
      else
        format.html { render :new }
        format.json { render json: @weekly_revenue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_revenues/1
  # PATCH/PUT /weekly_revenues/1.json
  def update
    respond_to do |format|
      if @weekly_revenue.update(weekly_revenue_params)
        format.html { redirect_to @weekly_revenue, notice: 'Weekly revenue was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_revenue }
      else
        format.html { render :edit }
        format.json { render json: @weekly_revenue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_revenues/1
  # DELETE /weekly_revenues/1.json
  def destroy
    @weekly_revenue.destroy
    respond_to do |format|
      format.html { redirect_to weekly_revenues_url, notice: 'Weekly revenue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_revenue
      @weekly_revenue = WeeklyRevenue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_revenue_params
      params.require(:weekly_revenue).permit(:week_start_date, :revenue)
    end
end
