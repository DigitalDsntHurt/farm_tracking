class UpcaseOrdersDayOfWeek < ActiveRecord::Migration[5.1]
  def up
    Order.all.each do |order|
      next if order.day_of_week == nil
      order.update(day_of_week: order.day_of_week.capitalize)
    end
  end
end
