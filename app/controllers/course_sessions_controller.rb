class CourseSessionsController < ApplicationController

  def create_course_session
    @course_session = CourseSession.new(course_session_params)

    if @course_session.save
      render json: { course_session: CourseSessionRepresenter.represent(@course_session) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def upcoming_courses
    @course_sessions = CourseSession.courses_in_next_week
    course_sessions_json = { upcoming_courses: CourseSessionRepresenter.for_collection.new(@course_sessions) }

    render json: { courses: course_sessions_json }
  end

  def get_students
    @course_session = CourseSession.find(params[:course_session_id])

    render json: { participants: @course_session.all_participants }
  end

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
