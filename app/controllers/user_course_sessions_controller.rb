class UserCourseSessionsController < ApplicationController

  def get_user_course_session
    @student = User.find_by_id(params[:user_id])
    @course_session = CourseSession.find_by_id(params[:course_session_id])
    @user_course_session = UserCourseSession.find_or_create_session(@student, @course_session)

    #user_course_sessions_json = { this_session: UserCourseSessionRepresenter.new(@user_course_session) }

    render json: { this_session: UserCourseSessionRepresenter.new(@user_course_session) }
  end

end
