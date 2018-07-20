require 'representable/json'

class CourseSessionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  #property
  # start_time
  # thumbnail url
  # video url
  # duration
  # instructor_name(instructor.first_name + instructor.last_name)
end
