require 'representable/json'

class ViewedPostureCourseRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :completed
  property :view_count
  property :favorite
  property :last_completed_at
  property :last_viewed_at
  property :last_favorited_at
  property :posture_course
  property :completed_count
end
