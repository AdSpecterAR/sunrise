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
end
