class CourseSessionsController < ApplicationController

  def upcoming_courses
    @course_sessions = CourseSession.courses_in_next_24_hours
    course_sessions_json = { upcoming_courses: CourseSessionRepresenter.for_collection.new(@course_sessions) }

    render json: { courses: course_sessions_json }
  end

  def get_students

    user_course_sessions = UserCourseSession
        .where(course_session_id: params[:course_session_id])

    users = user_course_sessions
                .map { |user_course_session| user_course_session.return_student_name }
    #render json: { user_course_session: UserCourseSessionRepresenter.new(@user_course_session) }
    render json: { user: users }

  end

end
