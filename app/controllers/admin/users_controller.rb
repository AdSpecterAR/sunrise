class Admin::UsersController < ApplicationController

  # this action creates an instructor
  def create
    @user = User.new(user_params)

    @user.instructor = true

    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }, status: 422
    end
  end

  protected

  def user_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :full_name,
        :email,
        :password,
      )
  end


end
