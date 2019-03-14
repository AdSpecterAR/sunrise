require 'representable/json'

class TrackRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :description
  property :image_url
  property :intro_video_url
  property :track_sections, extend: TrackSectionRepresenter
end
