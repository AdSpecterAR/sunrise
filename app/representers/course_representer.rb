require 'representable/json'

class CourseRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :duration
  property :instructor

end
