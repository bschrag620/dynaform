class SubmittedFormResponse < ApplicationRecord
  belongs_to :submitted_form

  belongs_to :form_input

  has_one :input_type,
    through: :form_input

  #
  # Override the default save method to run dyna_form validations after the data is persisted
  #
  # @return [Boolean]
  #
  def save
    result = super
    dyna_form_validate!
    result
  end

  def dyna_form_validate!
    form_input.input_type.klass.new(self)
  end

  def is_dyna_form_valid?
    dyna_form_validate!
    self.errors.empty?
  end

  def required?
    form_input.required
  end
end
