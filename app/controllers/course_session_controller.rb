class CourseSessionController < ApplicationController

  def upcoming_classes
    @sessions = courses_in_next_24_hours
    render json: {
        courses: {
            course_session: CourseSessionRepresenter.for_collection.represent(@sessions)
        }
    }
  end

end
