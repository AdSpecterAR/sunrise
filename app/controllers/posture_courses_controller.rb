class PostureCoursesController < ApplicationController

  def index
    @courses = PostureCourse.all
    render json: { courses: @courses }
  end

  def grouped_by_category
    @all_courses = PostureCourse.all
    @grouped_courses = @all_courses.group_by(&:category)
    @grouped_courses_array = @grouped_courses.map { |key, value| value }

    render json: { courses: @grouped_courses_array }
  end
end
