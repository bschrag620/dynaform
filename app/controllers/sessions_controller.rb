class SessionsController < ApplicationController
  # login_url
  def new
  end

  # authenticate the user and sign them in
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      user_session = @user.login!
      session[:current_session_id] = user_session.id

      redirect_to root_url
    else
      redirect_to login_url
    end
  end

  # logs the user out
  def delete
    Current.user.logout!

    redirect_to root_url
  end
end