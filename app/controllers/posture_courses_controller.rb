class PostureCoursesController < ApplicationController

  def index
    @courses = PostureCourse.all
    render json: { courses: @courses }
  end

end
