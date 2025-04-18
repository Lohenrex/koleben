json.extract! user, :id, :name, :apartment_number, :is_owner, :phone_number, :email_address, :created_at, :updated_at
json.url user_url(user, format: :json)
