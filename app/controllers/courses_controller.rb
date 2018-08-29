class CoursesController < ApplicationController

  def create_course
    @course = Course.new(course_params)

    if @course.save
      render json: { course: CourseRepresenter.represent(@course) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  #this gets all courses
  def get_courses
    render json: { courses: CourseRepresenter.for_collection.new(Course.all) }
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