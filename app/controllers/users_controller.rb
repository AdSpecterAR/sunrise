require 'securerandom'

class UsersController < ApplicationController
  before_action :set_user, only: [
    :viewed_course,
    :complete_course,
    :finish_onboarding,
    :select_track,
    :favorite_course,
    :unfavorite_course,
    :favorite_courses,
    :recent_courses
  ]

  def fetch_or_create_user
    @user = User.fetch_or_create_user(user_params)

    render json: { user: UserRepresenter.represent(@user) }
  end

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
    @user = User.fetch(params[:firebase_uid])

    render json: { user: UserRepresenter.represent(@user) }
  end

  def viewed_course
    if @user.find_or_create_viewed_course(params[:course_id])
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def complete_course
    if @user.complete_course(params[:course_id])
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def finish_onboarding
    if @user.finish_onboarding(onboarding_params)
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def favorite_course
    @course = ViewedPostureCourse.find(params[:viewed_posture_course_id])

    if @course.favorite_course
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def unfavorite_course
    @course = ViewedPostureCourse.find(params[:viewed_posture_course_id])

    if @course.unfavorite_course
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def favorite_courses
    @courses = @user.viewed_posture_courses.favorited

    render json: { courses: ViewedPostureCourseRepresenter.for_collection.represent(@courses) }
  end

  def recent_courses
    @courses = @user.viewed_posture_courses.completed

    render json: { courses: ViewedPostureCourseRepresenter.for_collection.represent(@courses) }
  end

  def select_track
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
      :fb_account,
      :password
    )
  end

  def onboarding_params
    params
      .require(:user)
      .permit(
        :age,
        :activity_level,
        :gender,
        :daily_notification_hour,
        :daily_notification_minute,
        :track_id,
        :goals_description
      )
  end

  def reason_params
    params
      .require(:user)
      .permit(:reason)
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

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
