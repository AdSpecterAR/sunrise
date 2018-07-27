class CourseSessionsController < ApplicationController

  def upcoming_courses
    @course_sessions = CourseSession.courses_in_next_24_hours
    course_sessions_json = { upcoming_courses: CourseSessionRepresenter.for_collection.new(@course_sessions) }

    render json: { courses: course_sessions_json }
  end

  def get_students
    @course_session = CourseSession.find(params[:course_session_id])

    render json: { participants: @course_session.all_participants }
  end

end
