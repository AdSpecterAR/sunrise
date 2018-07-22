class UsersController < ApplicationController
  before_action :authenticate_user!, except: :create

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end

  end

  def facebook_authentication
    #check if fb id exists, then create


    @user = User.new(facebook_params)

    if facebook_params[:email].nil?
      @user.email = "#{facebook_params[:first_name]}#{facebook_params[:last_name]}@facebook.com"
    end
    
    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  protected

  def user_params
    params
    .require(:user)
    .permit(
        :first_name,
        :last_name,
        :full_name,
        :email,
        :password
    )
  end

  def facebook_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :full_name,
        :email,
        :password,
        :fb_authentication_token,
        :fb_user_id,
        :fb_account
      )
  end
end
