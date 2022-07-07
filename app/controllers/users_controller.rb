class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    users = User.where(status: true)
    render json: users, status: 200
  end

  def show
    render json: @user.as_json, status: 200
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @user = User.new(user_params)
        @user.password = BCrypt::Password.create(user_params[:password])
        @user.save!
        render json: { message: "User was successfully created." }, status: 200
      end
    rescue Exception => error
      render json: { message: error.message }, status: 417
    end
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        errors_message = []
        if user_params[:password].blank?
          errors_message << 'Password Cant be Blank'
        elsif user_params[:password_confirmation].blank?
          errors_message << 'Password Confirmtion Cant be Blank'
        elsif user_params[:password] != user_params[:password_confirmation]
          errors_message << 'Password and Password confirmation should be same.'
        end
        if errors_message.blank?
          render json: { message: 'User was successfully updated.' }, status: 200
        else
          @user.update(user_params)
          render json: { message: 'User was successfully updated.' }, status: 200
        end
      end
    rescue Exception => error
      render json: { message: error.message }, status: 417
    end
  end

  def destroy
    begin
      ActiveRecord::Base.transaction do
        @user.update(status: false)
        render json: { message: "User was successfully deleted." }, status: 200
      end
    rescue Exception => error
      render json: { message: error.message }, status: 417
    end
  end

  def login
    user_name
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :status, :phone_number)
    end
end
