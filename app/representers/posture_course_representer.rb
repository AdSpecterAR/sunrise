require 'representable/json'

class PostureCourseRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :active
  property :name
  property :description
  property :duration
  property :category
  property :difficulty
  property :setup_instructions
  property :equipment
  property :video_thumbnail_url
  property :video_url
  property :gif_url
  property :audio_url
  property :thumbnail_image_url
  property :order_in_track
  property :completed_count
  property :favorited_count
  property :view_count
  property :last_completed_at
  property :last_favorited_at
  property :last_viewed_at
end
