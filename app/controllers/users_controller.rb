class UsersController < ApplicationController
  # signup_url
  def new
    @user ||= User.new
  end

  # create user and sign them in
  def create
    @user = User.create(user_create_params)
    if @user.save
      user_session = @user.login!
      session[:current_session_id] = user_session.id

      redirect_to root_url
    else
      render :new
    end
  end

  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end