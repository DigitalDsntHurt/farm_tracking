class TeamMembersShiftsController < ApplicationController
  before_action :set_team_members_shift, only: [:show, :edit, :update, :destroy]

  # GET /team_members_shifts
  # GET /team_members_shifts.json
  def index
    @team_members_shifts = TeamMembersShift.all.order(shift_date: :desc)

    # get week start dates
    @start_date = Date.new(2019,07,01)
    @week_start_dates = [@start_date]
    until Date.today - @start_date < 0
      @week_start_dates << @start_date += 7
    end
  end

  # GET /team_members_shifts/1
  # GET /team_members_shifts/1.json
  def show
  end

  # GET /team_members_shifts/new
  def new
    @team_members_shift = TeamMembersShift.new
  end

  # GET /team_members_shifts/1/edit
  def edit
  end

  # POST /team_members_shifts
  # POST /team_members_shifts.json
  def create
    @team_members_shift = TeamMembersShift.new(team_members_shift_params)

    respond_to do |format|
      if @team_members_shift.save
        format.html { redirect_to team_members_shifts_path, notice: 'Team members shift was successfully created.' }
        format.json { render :show, status: :created, location: @team_members_shift }
      else
        format.html { render :new }
        format.json { render json: @team_members_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_members_shifts/1
  # PATCH/PUT /team_members_shifts/1.json
  def update
    respond_to do |format|
      if @team_members_shift.update(team_members_shift_params)
        format.html { redirect_to @team_members_shift, notice: 'Team members shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_members_shift }
      else
        format.html { render :edit }
        format.json { render json: @team_members_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_members_shifts/1
  # DELETE /team_members_shifts/1.json
  def destroy
    @team_members_shift.destroy
    respond_to do |format|
      format.html { redirect_to team_members_shifts_url, notice: 'Team members shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_members_shift
      @team_members_shift = TeamMembersShift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_members_shift_params
      params.require(:team_members_shift).permit(:team_member_id, :shift_date, :shift_hrs, :paid_date)
    end
end
