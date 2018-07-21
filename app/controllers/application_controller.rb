class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  def render_error(e, status)
    msg = e.is_a?(ActiveModel::Errors) ? e.full_messages : e.to_s
    render json: { error: msg }, status: status
  end
end
