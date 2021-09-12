class ApplicationController < ActionController::Base
  before_action :set_current, :redirect_if_not_logged_in

  def index
    @dyna_forms = DynaForm.all
    @dyna_form = DynaForm.new
  end

  private
  def set_current
    Current.session = Session.find_by(id: session[:current_session_id]) if session.include?(:current_session_id)
  end

  def redirect_if_not_logged_in
    redirect_to login_url unless Current.user
  end
end
