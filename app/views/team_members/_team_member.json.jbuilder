json.extract! team_member, :id, :fname, :lname, :start_date, :birthday, :phone, :email, :address, :social_links, :created_at, :updated_at
json.url team_member_url(team_member, format: :json)
