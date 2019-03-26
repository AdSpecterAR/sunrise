require 'representable/json'

class UserRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :first_name
  property :last_name
  property :full_name
  property :username
  property :email
  property :admin
  property :instructor
  property :authentication_token
  property :firebase_uid
  property :fb_authentication_token
  property :fb_user_id
  property :fb_account
  # property :current_track, decorator: TrackRepresenter, class: Track, getter: ->(_) { current_track.track if current_track.present? }
  property :current_track, decorator: ViewedTrackRepresenter, class: ViewedTrack
  collection :viewed_posture_courses do
    property :completed
    property :posture_course
  end
end
