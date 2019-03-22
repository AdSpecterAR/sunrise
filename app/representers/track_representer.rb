require 'representable/json'

class TrackRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :description
  property :image_url
  property :intro_video_url
  collection :posture_courses do
    :id
    :name
    :duration
    :category
    :difficulty
    :equipment
    :description
    :video_url
    :gif_url
    :audio_url
    :thumbnail_image_url
  end
end
