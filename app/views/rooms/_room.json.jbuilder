json.extract! room, :id, :name, :location, :address, :created_at, :updated_at
json.url room_url(room, format: :json)
