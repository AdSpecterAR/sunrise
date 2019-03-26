require 'representable/json'

class ViewedTrackRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :user_id
  collection :viewed_courses
  property :completed_courses
  property :last_completed_course_number
  property :track, extend: TrackRepresenter, class: Track
end
