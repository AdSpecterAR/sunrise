require 'securerandom'

class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def index
    @user = User.find_by(firebase_uid: params[:firebase_uid])

    render json: { user: UserRepresenter.represent(@user) }
  end

  def viewed_course
    @user = User.find(params[:user_id])

    if @user.find_or_create_viewed_course(params[:course_id])
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def complete_course
    @user = User.find(params[:user_id])
    @viewed_posture_course = ViewedPostureCourse.find_by(
                                                  posture_course_id: params[:course_id],
                                                  user: @user
                                                )

    if @viewed_posture_course.update(completed: true)
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def select_track
    @user = User.find(params[:user_id])
    @track = Track.find(params[:track_id])

    @viewed_track = ViewedTrack.new(user_id: @user.id, track_id: @track.id)

    if @viewed_track.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
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
      :firebase_uid,
      :current_track,
      :password
    )
  end

  def viewed_course_params
    params
      .require(:viewed_course)
      .permit(
        :user_id,
        :course_id
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
