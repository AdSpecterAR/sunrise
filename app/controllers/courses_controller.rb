class CoursesController < ApplicationController

  #this gets all courses, this might not scale well when we have more courses
  def get_courses
    render json: { courses: CourseRepresenter.for_collection.new(Course.all) }
  end

end
