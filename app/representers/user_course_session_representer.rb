require 'representable/json'

class UserCourseSessionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :rating
  property :comment
  property :course_session
  property :student
  property :created_at
  property :updated_at
end
