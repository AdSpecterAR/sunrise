require 'representable/json'

class UserCourseSessionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :rating
  property :comment
  property :course_session

end