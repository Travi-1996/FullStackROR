module UsersHelper

  def encode_user_data(payload)
    return JWT.encode payload, AdminType::SECRET_KEY, "HS256"
  end

  def decode_user_data(token)
    begin
      return JWT.decode token, AdminType::SECRET_KEY, true, { algorithm: "HS256" }
    rescue => e
      puts e
      render_invalid_session
    end
  end
end
