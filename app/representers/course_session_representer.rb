require 'representable/json'

class CourseSessionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :start_time
  property :thumbnail_image_url
  property :video_url
  property :duration
  property :instructor_full_name
  property :course
  property :course_id
  property :live
end
