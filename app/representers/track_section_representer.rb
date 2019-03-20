require 'representable/json'

class TrackSectionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :description
  property :image_url
  property :intro_video_url
  property :number
  collection :posture_courses
end
