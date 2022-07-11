class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  skip_before_action :authentication, only: %i[ login ]
  before_action :check_user_params, only: %i[ login forgot_password ]

  def index
    users = User.where(status: true)
    render json: users, status: 200 and return
  end

  def show
    render json: @user.as_json, status: 200 and return
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    begin
      @user = User.new(user_params)
      # params
      # @user
      @user.save!
      render json: { message: "User was successfully created." }, status: 200 and return
    rescue Exception => error
      message = error.message.split(':')
      message.shift()
      render json: { message: message.join(',') }, status: 417 and return
    end
  end

  def update
    begin
      @user.update!(user_params)
      render json: { message: 'User was successfully updated.' }, status: 200 and return
    rescue Exception => error
      message = error.message.split(':')
      message.shift()
      render json: { message: message.join(',') }, status: 417 and return
    end
  end

  def destroy
    begin
      @user.update(status: false)
      render json: { message: "User was successfully deleted." }, status: 200 and return
    rescue Exception => error
      render json: { message: error.message }, status: 417 and return
    end
  end

  def login
    if @user.present?
      response = AuthService.new(@user).update_auth_details
      render json: { response: response, message: 'User Logged in Successfully' }, status: 200 and return
    else
      render json: { message: "There is no User present for this email: #{params[:email]}" }, status: 417 and return
    end
  end

  def logout
    token = request.headers['HTTP_WWWAUTHENTICATE']
    token_data = Rails.cache.read(AdminType::USER_SESSION_URL + token.to_s)
    if token_data.nil?
      render json: { message: "User has been logged out successfuly" }, status: 200 and return
    else
      Rails.cache.delete(AdminType::USER_SESSION_URL + token.to_s)
    end
    render json: { message: "User has been logged out successfuly" }, status: 200 and return
  end

  def forgot_password
    begin
      @user.update!(password: params[:password])
      render json: { message: 'Password updated successfully.' }, status: 200 and return
    rescue Exception => error
      message = error.message.split(':')
      message.shift()
      render json: { message: message.join(',') }, status: 417 and return
    end
  end

  private
    def set_user
      begin
        @user = User.find(params[:id])
      rescue Exception => error
        render json: { message: error.message }, status: 417 and return
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :address, :status, :phone_number)
    end

    def check_user_params
      error_msg = []
      if params[:email].blank?
        error_msg << 'User Name can not be blank'
      elsif params[:password].blank?
        error_msg << 'Password can not be blank'
        check_password_length
      elsif params[:password].present?
        check_password_length
      end
      render json: { message: error_msg }, status: 417 and return if error_msg.present?
      @user = User.where(email: params[:email], password: params[:password]).last
    end

    def check_password_length
      is_valid = params[:password].length < 13 && params[:password].length >= 8
      render json: { message: 'Password should be min 8 charecter or max 12 character' }, status: 417 and return if !is_valid
    end
end
