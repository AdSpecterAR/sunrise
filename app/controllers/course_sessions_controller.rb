class CourseSessionsController < ApplicationController

  def upcoming_courses
    @course_sessions = CourseSession.courses_in_next_24_hours
    course_sessions_json = { upcoming_courses: CourseSessionRepresenter.for_collection.new(@course_sessions) }

    render json: { courses: course_sessions_json }
  end

end
