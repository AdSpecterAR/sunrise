class Admin::CoursesController < ApplicationController

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: { course: CourseRepresenter.represent(@course) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  def course_params
    params
      .require(:course)
      .permit(
        :name,
        :duration,
        :category,
        :difficulty,
        :instructor_id,
        :description,
        :equipment
      )
  end
end
