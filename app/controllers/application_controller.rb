class ApplicationController < ActionController::Base
  before_action :authentication

  def authentication
    check_session || render_invalid_session
  end

  def check_session
    token = request.headers['HTTP_WWWAUTHENTICATE']
    user_id = Rails.cache.read(AdminType::USER_SESSION_URL + token.to_s)
    return false if user_id.blank?
    @current_user = User.find_by(id: user_id, status: true)
    return false if @current_user.blank?
    return true
  end

  def render_invalid_session
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { message: 'Session has been timed out. Please login' }, status: 401 and return
  end
end
