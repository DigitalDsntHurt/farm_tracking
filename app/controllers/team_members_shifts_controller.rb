class TeamMembersShiftsController < ApplicationController
  before_action :set_team_members_shift, only: [:show, :edit, :update, :destroy]

  # GET /team_members_shifts
  # GET /team_members_shifts.json
  def index
    @team_members_shifts = TeamMembersShift.all.order(planned_shift_date: :desc)
    @monday = Date.today
    unless @monday.monday?
      until @monday.monday?
        @monday -= 1
      end
    end
    @sunday = @monday + 6

    @planned_shifts_this_week = TeamMembersShift.where('planned_shift_date >= ? AND planned_shift_date <= ?', @monday, @sunday)
    if @planned_shifts_this_week.count > 0
      @planned_hours_this_week = @planned_shifts_this_week.map{|shift| shift.planned_shift_hrs }.inject{|hrs,sum| hrs + sum }
    else
      @planned_hours_this_week = 0
    end
  end

  def summary
    @monday = Date.today
    unless @monday.monday?
      until @monday.monday?
        @monday -= 1
      end
    end
    @sunday = @monday + 6

    @planned_shifts_this_week = TeamMembersShift.where('planned_shift_date >= ? AND planned_shift_date <= ?', @monday, @sunday)
    @actual_shifts_this_week = TeamMembersShift.where('actual_shift_date >= ? AND actual_shift_date <= ?', @monday, @sunday)
    
    @planned_hours_this_week = @planned_shifts_this_week.map{|shift| shift.planned_shift_hrs }.inject{|hrs,sum| hrs + sum }
    @actual_hours_this_week = @actual_shifts_this_week.map{|shift| shift.actual_shift_hrs }.inject{|hrs,sum| hrs + sum }

    if @actual_hours_this_week == 0
     @paid_hrs_this_week = 0
    else  
      @paid_hrs_this_week = @actual_shifts_this_week.where(paid: true).where.not(actual_shift_hrs: nil).map{|shift| shift.actual_shift_hrs }.inject{|hrs,sum| hrs + sum }
      @paid_hrs_this_week += @planned_shifts_this_week.where(paid: true).where(actual_shift_hrs: nil).map{|shift| shift.planned_shift_hrs }.inject{|hrs,sum| hrs + sum } #* 15
    end

    @history = []
    30.times do 
      @shifts = TeamMembersShift.where('actual_shift_date >= ? AND actual_shift_date <= ?', @monday, @sunday)
      @weekly_hrs = @shifts.map{|shift| shift.planned_shift_hrs }.inject{|hrs,sum| hrs + sum }
      @planned_shifts_this_week = TeamMembersShift.where('planned_shift_date >= ? AND planned_shift_date <= ?', @monday, @sunday)
      @actual_shifts_this_week = TeamMembersShift.where('actual_shift_date >= ? AND actual_shift_date <= ?', @monday, @sunday)
      if @actual_shifts_this_week.count != 0
        @paid_hrs_this_week = @actual_shifts_this_week.where(paid: true).where.not(actual_shift_hrs: nil).map{|shift| shift.actual_shift_hrs }.inject{|hrs,sum| hrs + sum }
        @paid_hrs_this_week += @planned_shifts_this_week.where(paid: true).where(actual_shift_hrs: nil).map{|shift| shift.planned_shift_hrs }.inject{|hrs,sum| hrs + sum } #* 15
      end
      @history << [@monday,@weekly_hrs,@paid_hrs_this_week]
      @monday -= 7
      @sunday -= 7
    end
    @history.reject!{|wk| wk[1] == nil }
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
        format.json { render :index, status: :created, location: @team_members_shift }
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
        format.html { redirect_to team_members_shifts_path, notice: 'Team members shift was successfully updated.' }
        format.json { render :index, status: :ok, location: @team_members_shift }
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

  def clone
    @team_members_shift = TeamMembersShift.find(params[:shift]).dup
    render new_team_members_shift_path(@team_members_shift)
  end

  def log
    @team_members_shift = TeamMembersShift.find(params[:team_members_shift])
    #@seed_flat = SeedFlat.find(params[:flat])]
  end

  def bulk_actions
    #unless params[:shift_ids] == nil
      if params[:commit] == "Log With Pay"
        params[:shift_ids].each{|id|
          @shift = TeamMembersShift.where(id: id)[0]
          @shift.update(actual_shift_hrs: @shift.planned_shift_hrs, actual_shift_date: @shift.planned_shift_date, paid: true )
        }
        redirect_to team_members_shifts_path
      elsif params[:commit] == "Log Without Pay"
        params[:shift_ids].each{|id|
          @shift = TeamMembersShift.where(id: id)[0]
          @shift.update(actual_shift_hrs: @shift.planned_shift_hrs, actual_shift_date: @shift.planned_shift_date, paid: false )
        }
        redirect_to team_members_shifts_path
      elsif params[:commit] == "Log Pay Only"
        params[:shift_ids].each{|id|
          @shift = TeamMembersShift.where(id: id)[0]
          @shift.update( paid: true )
        }
        redirect_to team_members_shifts_path
      end
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_members_shift
      @team_members_shift = TeamMembersShift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_members_shift_params
      params.require(:team_members_shift).permit(:team_member_id, :planned_shift_date, :planned_shift_hrs, :paid_date, :actual_shift_hrs, :actual_shift_date, :paid)
    end
end
