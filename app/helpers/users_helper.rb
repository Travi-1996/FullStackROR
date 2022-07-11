module UsersHelper

  def generate_authentication_token
    token = nil
    loop do
      token = SecureRandom.base64(64)
      break unless Rails.cache.read(AdminType::USER_SESSION_URL + token.to_s)
    end
    return token.to_s
  end
end
