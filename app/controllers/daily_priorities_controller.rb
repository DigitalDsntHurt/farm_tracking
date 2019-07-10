class DailyPrioritiesController < ApplicationController
  before_action :set_daily_priority, only: [:show, :edit, :update, :destroy]

  # GET /daily_priorities
  # GET /daily_priorities.json
  def index
    @daily_priorities = DailyPriority.all.order(date: :desc)
  end

  # GET /daily_priorities/1
  # GET /daily_priorities/1.json
  def show
  end

  # GET /daily_priorities/new
  def new
    @daily_priority = DailyPriority.new
  end

  def n_form
    @daily_priority = DailyPriority.new
  end

  def d_form
    @daily_priority = DailyPriority.new
  end

  # GET /daily_priorities/1/edit
  def edit
  end

  # POST /daily_priorities
  # POST /daily_priorities.json
  def create
    @daily_priority = DailyPriority.new(daily_priority_params)

    respond_to do |format|
      if @daily_priority.save
        format.html { redirect_to daily_priorities_path, notice: 'Daily priority was successfully created.' }
        format.json { render :show, status: :created, location: @daily_priority }
      else
        format.html { render :new }
        format.json { render json: @daily_priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_priorities/1
  # PATCH/PUT /daily_priorities/1.json
  def update
    respond_to do |format|
      if @daily_priority.update(daily_priority_params)
        format.html { redirect_to @daily_priority, notice: 'Daily priority was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_priority }
      else
        format.html { render :edit }
        format.json { render json: @daily_priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_priorities/1
  # DELETE /daily_priorities/1.json
  def destroy
    @daily_priority.destroy
    respond_to do |format|
      format.html { redirect_to daily_priorities_url, notice: 'Daily priority was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def weekly_dash
    # get week start dates
    @start_date = Date.new(2019,06,24)
    @week_start_dates = [@start_date]
    until Date.today - @start_date < 0
      @week_start_dates << @start_date += 7
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_priority
      @daily_priority = DailyPriority.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_priority_params
      params.require(:daily_priority).permit(:initial, :one, :oneexecuted, :two, :twoexecuted, :date)
    end
end
