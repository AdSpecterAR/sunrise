class CourseSessionsController < ApplicationController

  def upcoming_courses
    @course_sessions = CourseSession.courses_in_next_week
    course_sessions_json = { upcoming_courses: CourseSessionRepresenter.for_collection.new(@course_sessions) }

    render json: { courses: course_sessions_json }
  end

  def get_students
    @course_session = CourseSession.find(params[:course_session_id])

    render json: { participants: @course_session.all_participants }
  end

  #this gets all courses
  def get_courses
    render json: { courses: CourseRepresenter.for_collection.new(Course.all) }
  end

end
