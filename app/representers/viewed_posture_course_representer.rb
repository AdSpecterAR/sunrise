require 'representable/json'

class ViewedPostureCourseRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :completed
  property :last_favorited_at
  property :last_completed_at
  property :last_viewed_at
  property :completed_count
  property :favorite
  property :view_count
  property :posture_course, decorator: PostureCourseRepresenter, class: PostureCourse
end
