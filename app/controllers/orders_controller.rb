class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.order(:customer_id, :day_of_week)
    @customer_orders = @orders.select{|order| order.cancelled_on == nil }.group_by{|order| order.customer_id }
  end

  def current_index
    @orders = Order.where(cancelled_on: nil).order(:customer_id, :day_of_week)
    @customer_orders = @orders.select{|order| order.cancelled_on == nil }.group_by{|order| order.customer_id }
  end

  def orders_calendar
    # setup calendar cells
    @today = Date.today
    if @today.strftime("%a") == "Mon"
      @start_date = @today
    else
        @start_date = @today
        until @start_date.strftime("%a") == "Mon"
          @start_date -= 1
        end
    end
    @end_date = @start_date+42
    @date_range = (@start_date..@end_date)
    @weeks = @date_range.to_a.in_groups_of(7)

    @orders = Order.where(cancelled_on: nil).where.not(customer_id: 1).order(:customer_id, :day_of_week)
    @ad_hoc_orders = Order.where(cancelled_on: nil).where(standing_order: false)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  def new_standing_order_form
    
    if params[:pass_customer_id] == nil
      @order = Order.new
    else
      @order = Order.new(customer_id: params[:pass_customer_id])
    end
  end

  def new_ad_hoc_order_form
    if params[:pass_customer_id] == nil
      @order = Order.new
    else
      @order = Order.new(customer_id: params[:pass_customer_id])
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def clone
    @order = Order.find(params[:order]).dup
    render new_order_path(@order)
  end

  def cancel
    @order = Order.find(params[:order])
    @order.update(cancelled_on: Date.today)
    redirect_back(fallback_location: orders_path)
  end  

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer, :day_of_week, :date, :qty_oz, :crop, :variety, :crop_id, :cancelled_on, :standing_order, :customer_id, :maturity_days, :harvest_preferences, :start_date)
    end
end
