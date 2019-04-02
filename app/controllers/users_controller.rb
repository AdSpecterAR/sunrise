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

    if @user.complete_course(params[:course_id])
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
