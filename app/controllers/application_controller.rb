class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?



  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |type|
      type.all  { render nothing: true, status: 404 }
    end
  end

  protected

  def clean_parameters
    params.delete :session
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def render_error(e, status)
    msg = e.is_a?(ActiveModel::Errors) ? e.full_messages : e.to_s
    render json: { error: msg }, status: status
  end

  private
  def  protect_from_forgery
  end
end
