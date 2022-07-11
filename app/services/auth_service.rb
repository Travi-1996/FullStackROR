class AuthService
  include UsersHelper
  
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def update_auth_details
    token = fetch_auth_token
    roles = []
    
    return {
      token: token,
      current_user_obj: @user.as_json,
      roles: roles
    }
  end

  private

  def fetch_auth_token
    token = generate_authentication_token
    Rails.cache.write((AdminType::USER_SESSION_URL + token.to_s), @user.id, expires_in: 1.days)
    return token
  end
end