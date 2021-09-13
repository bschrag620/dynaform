class ApplicationController < ActionController::Base
  before_action :set_current, :redirect_if_not_logged_in

  def index
    @dyna_forms = Current.user.dyna_forms
    @dyna_form = DynaForm.new
  end

  private
  def set_current
    Current.session = Session.find_by(id: session[:current_session_id]) if session.include?(:current_session_id)
    Current.user = Current.session&.user
  end

  def redirect_if_not_logged_in
    redirect_to login_url unless Current.user
  end

  def redirect_if_logged_in
    redirect_to root_url if Current.session
  end
end
