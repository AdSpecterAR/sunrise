require 'representable/json'

class UserCourseSessionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :rating
  property :comment
  property :course_name
  property :course_category
  property :course_difficulty
  property :course_description
  property :course_equipment
  #property :course_session, decorator: CourseSessionRepresenter
  property :course_session
  property :student
  property :created_at
  property :updated_at
end
