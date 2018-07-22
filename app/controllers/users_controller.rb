class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create, :facebook_authentication]

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end

  end

  def facebook_authentication
    # TODO: if user exists, sign in. Otherwise create new user

    # SIGN IN
    # user = User.where(fb_user_id: facebook_params[:fb_user_id])
    #
    #

    # CREATE NEW USER
    @user = User.new(facebook_params)

    if facebook_params[:email].nil?
      @user.email = "#{facebook_params[:first_name]}#{facebook_params[:last_name]}@facebook.com"
    end

    @user.password = @user.email # needs password to pass validation
    
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
