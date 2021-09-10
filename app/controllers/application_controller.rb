class ApplicationController < ActionController::Base
  before_action :set_current

  def index
  end

  private
  def set_current
    Current.session = Session.find_by(id: session[:current_session_id]) if session.include?(:current_session_id)
    Current.user = Current.session.user if Current.session && Current.session.not_expired?
  end
end
