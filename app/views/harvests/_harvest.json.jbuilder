json.extract! harvest, :id, :customer_id, :crop_id, :order_id, :qty_oz, :instructions, :date, :time, :completed, :created_at, :updated_at
json.url harvest_url(harvest, format: :json)
