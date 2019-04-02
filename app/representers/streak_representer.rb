require 'representable/json'

class StreakRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :first_course_date
  property :last_course_date
  property :active
  property :length
  property :user_id
end
