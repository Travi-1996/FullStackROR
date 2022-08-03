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
    return encode_user_data({ user_id: @user.id })
  end
end