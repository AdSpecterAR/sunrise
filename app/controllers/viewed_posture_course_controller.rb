require 'securerandom'

class ViewedPostureCoursesController < ApplicationController

  def new_course_view
    @viewed_course = ViewedPostureCourse.find_or_create_by!(
                                          user_id: viewed_course_params[:user_id],
                                          posture_course_id: viewed_course_params[:course_id]
                                        )


  end

  def viewed_course_params
    params
      .require(:viewed_course)
      .permit(
        :user_id,
        :course_id
      )
  end
end
