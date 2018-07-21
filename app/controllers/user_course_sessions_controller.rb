class UserCourseSessionsController < ApplicationController

  def get_user_course_session
    @student = User.find_by_id(params[:user_id])
    @course_session = CourseSession.find_by_id(params[:course_session_id])
    @user_course_session = UserCourseSession.find_or_create_session(@student, @course_session)

    #user_course_sessions_json = { this_session: UserCourseSessionRepresenter.new(@user_course_session) }

    render json: { user_course_session: UserCourseSessionRepresenter.new(@user_course_session) }
  end

  def post_feedback
    @user_course_session = UserCourseSession.find_by_id(params[:user_course_session_id])

    if @user_course_session.update(feedback_params)
      render json: { user_course_session: UserCourseSessionRepresenter.new(@user_course_session) }
    else
      render_error @user_course_session.errors, :unprocessable_entity
    end
    # @user_course_session.add_feedback(params[:rating], params[:comment])
  end

  def feedback_params
    params
      .require(:user_course_session)
      .permit(
        :rating,
        :comment
      )
  end

end
