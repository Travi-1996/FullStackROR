class ApplicationController < ActionController::Base
  before_action :authentication
  include UsersHelper

  def authentication
    check_session || render_invalid_session
    @current_user = User.find_by(id: 1)
  end

  def check_session
    token = request.headers['HTTP_WWWAUTHENTICATE']
    decode_data = decode_user_data(token)
    return false if decode_data.blank?
    user_id = decode_data[0]["user_id"]
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
