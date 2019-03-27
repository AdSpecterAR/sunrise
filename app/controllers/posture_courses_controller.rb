class PostureCoursesController < ApplicationController

  def index
    @courses = PostureCourse.all
    render json: { courses: @courses }
  end

  def grouped_by_category
    @all_courses = PostureCourse.all

    @grouped_courses = @all_courses.group_by(&:category)

    render json: { courses: @grouped_courses }
  end
end
