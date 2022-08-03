json.extract! message, :id, :username, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
