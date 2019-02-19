json.extract! scheduled, :id, :verb, :date, :crop, :variety, :customer, :order, :completed_on, :created_at, :updated_at
json.url scheduled_url(scheduled, format: :json)
