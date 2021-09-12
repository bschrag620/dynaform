class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user

  def input_types
    @input_types ||= InputType.all
  end
end