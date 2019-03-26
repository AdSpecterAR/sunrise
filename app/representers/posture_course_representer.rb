require 'representable/json'

class PostureCourseRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :description
  property :duration
  property :category
  property :difficulty
  property :equipment
  property :video_url
  property :gif_url
  property :audio_url
  property :thumbnail_image_url
  property :order_in_track
end
