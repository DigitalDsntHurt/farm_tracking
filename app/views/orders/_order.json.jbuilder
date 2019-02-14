json.extract! order, :id, :customer, :day_of_week, :date, :qty_oz, :crop, :variety, :created_at, :updated_at
json.url order_url(order, format: :json)
