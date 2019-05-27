class PostureCoursesController < ApplicationController

  def index
    @courses = PostureCourse.all
    render json: { courses: @courses }
  end

  def grouped_by_category
    @explore_courses = PostureCourse.explore
    @grouped_courses = @explore_courses.group_by(&:category)
    @grouped_courses_array = @grouped_courses.map { |key, value| value }

    render json: { courses: @grouped_courses_array }
  end
end
