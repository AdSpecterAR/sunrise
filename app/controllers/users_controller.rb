require 'securerandom'

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:get_instructors, :create, :facebook_authentication]

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def get_instructors
    @instructors = User.instructors
    instructors_json = { instructors: UserRepresenter.for_collection.new(@instructors) }
    render json: { users: instructors_json }
  end

  def facebook_authentication
    @fb_user_id = facebook_params[:fb_user_id]
    #checks if this user already exists
    @user = User.find_by(fb_user_id: @fb_user_id)

    if @user.nil?
      #user does not exist, creates a new user
      @user = User.new(facebook_params)

      #user doesn't have an email, we need email for validation so we make a fake one
      if facebook_params[:email].nil?
        @random_string = SecureRandom.hex
        @user.email = "#{facebook_params[:first_name]}#{facebook_params[:last_name]}#{@random_string}@facebook.com"
      end

      @user.password = @user.email # needs password to pass validation

      #returns user if successfully saved, else returns error
      if @user.save
        render json: { user: UserRepresenter.represent(@user) }
      else
        render json: { error: "error" }, status: 422
      end

    else
      #user already exists, sign them in
      render json: { user: UserRepresenter.represent(@user) }
      #signs in existing user, still have to create sessions for sign in later!
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
        :fb_authentication_token,   #TODO : have to authenticate this
        :fb_user_id,
        :fb_account
      )
  end
end
