require 'representable/json'

class CourseRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :duration
  property :category
  property :difficulty
  property :instructor_id
  property :description
  property :equipment


end
