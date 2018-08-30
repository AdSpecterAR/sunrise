class Admin::CourseSessionsController < ApplicationController

  def create
    @course_session = CourseSession.new(course_session_params)

    if @course_session.save
      render json: { course_session: CourseSessionRepresenter.represent(@course_session) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  protected


  def course_session_params
    params
      .require(:course)
      .permit(
        :start_time,
        :duration,
        :video_url,
        :thumbnail_image_url,
        :course_id,
        )
  end

end
