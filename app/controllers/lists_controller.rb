class ListsController < ApplicationController
  
  def soak
    #
    ## get soak todos for this week's ops days
    #
    @monday = FarmOpsDo.monday_soak_records
    @monday_done_count = @monday.where.not(completed_on: nil).count
    @monday_soaks = @monday.sort_by{|soak_do| soak_do.qty }.reverse.map{|soak_do| ["#{soak_do.qty} #{soak_do.qty_units} #{Crop.where(id: Order.where(id: soak_do.order_ids)[0].crop_id)[0].crop_variety}, #{Crop.where(id: Order.where(id: soak_do.order_ids)[0].crop_id)[0].crop}", {info: "Soaking #{soak_do.qty} #{soak_do.qty_units} #{Crop.where(id: Order.where(id: soak_do.order_ids[0])[0].crop_id)[0].crop_variety}, #{Crop.where(id: Order.where(id: soak_do.order_ids[0])[0].crop_id)[0].crop.capitalize}", crop_id: Order.where(id: soak_do.order_ids[0])[0].crop_id, soak_qty: soak_do.qty, order_ids: soak_do.order_ids, orders: soak_do.order_ids.join(",")}, soak_do] }

    @wednesday = FarmOpsDo.wednesday_soak_records
    @wednesday_done_count = @wednesday.where.not(completed_on: nil).count
    @wednesday_soaks = @wednesday.sort_by{|soak_do| soak_do.qty }.reverse.map{|soak_do| ["#{soak_do.qty} #{soak_do.qty_units} #{Crop.where(id: Order.where(id: soak_do.order_ids)[0].crop_id)[0].crop_variety}, #{Crop.where(id: Order.where(id: soak_do.order_ids)[0].crop_id)[0].crop}", {info: "Soaking #{soak_do.qty} #{soak_do.qty_units} #{Crop.where(id: Order.where(id: soak_do.order_ids[0])[0].crop_id)[0].crop_variety}, #{Crop.where(id: Order.where(id: soak_do.order_ids[0])[0].crop_id)[0].crop.capitalize}", crop_id: Order.where(id: soak_do.order_ids[0])[0].crop_id, soak_qty: soak_do.qty, order_ids: soak_do.order_ids, orders: soak_do.order_ids.join(",")}, soak_do] }

    @friday = FarmOpsDo.friday_soak_records
    @friday_done_count = @friday.where.not(completed_on: nil).count
    @friday_soaks = @friday.sort_by{|soak_do| soak_do.qty }.reverse.map{|soak_do| ["#{soak_do.qty} #{soak_do.qty_units} #{Crop.where(id: Order.where(id: soak_do.order_ids)[0].crop_id)[0].crop_variety}, #{Crop.where(id: Order.where(id: soak_do.order_ids)[0].crop_id)[0].crop}", {info: "Soaking #{soak_do.qty} #{soak_do.qty_units} #{Crop.where(id: Order.where(id: soak_do.order_ids[0])[0].crop_id)[0].crop_variety}, #{Crop.where(id: Order.where(id: soak_do.order_ids[0])[0].crop_id)[0].crop.capitalize}", crop_id: Order.where(id: soak_do.order_ids[0])[0].crop_id, soak_qty: soak_do.qty, order_ids: soak_do.order_ids, orders: soak_do.order_ids.join(",")}, soak_do] }

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