json.extract! user, :id, :name, :email, :password, :password_confirmation, :status, :phone_number, :token, :created_at, :updated_at
json.url user_url(user, format: :json)
