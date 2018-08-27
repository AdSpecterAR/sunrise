# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   supe
  # end

  # POST /resource/sign_in
  def create
    #super excecutes the devise create method
    puts 'super'
    super
    puts '0'
    @user = User.where(email: params[:email]).first
puts '1'
    if @user&.valid_password?(params[:password])
      puts '2'
      render json: { user: UserRepresenter.represent(@user) }
    else
      puts '3'
      head(:unauthorized)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
