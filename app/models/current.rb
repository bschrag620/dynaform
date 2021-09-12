class Current < ActiveSupport::CurrentAttributes
  attribute :session

  def user
    @user ||= Current.session.user if Current.session.present?
  end

  def input_types
    @input_types ||= InputType.all
  end
end