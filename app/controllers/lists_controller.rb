class ListsController < ApplicationController
  def soak

  end


  def harvest
  	# setup calendar cells
    @start_date = Date.today
    @end_date = @start_date+5
    @date_range = (@start_date..@end_date)
    @weeks = @date_range.to_a.in_groups_of(2)

    @orders = Order.where(cancelled_on: nil).where.not(customer_id: 1).order(:customer_id, :day_of_week)
    @ad_hoc_orders = Order.where(cancelled_on: nil).where(standing_order: false)
  end


end