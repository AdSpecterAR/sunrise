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
end
