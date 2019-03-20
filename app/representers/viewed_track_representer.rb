require 'representable/json'

class ViewedTrackRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :user_id
  property :track, extend: TrackRepresenter
end
