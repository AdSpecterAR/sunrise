class CoursesController < ApplicationController

  #this gets all courses, this might not scale well when we have more courses
  def get_courses
    @courses = Course.all.sort_by { |course| course.created_at }.reverse!
    render json: { courses: CourseRepresenter.for_collection.new(@courses) }
  end

end
