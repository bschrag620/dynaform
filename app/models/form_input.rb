class FormInput < ApplicationRecord
  belongs_to :dyna_form
  belongs_to :input_type

  has_many :submitted_form_responses

  validates :label, presence: true
  validate :has_additional_attributes?

  after_create_commit do
    broadcast_append_to("dyna_form_#{dyna_form.id}_form_input_samples",
      target: "dyna_form_#{dyna_form.id}_form_input_samples",
      partial: 'form_inputs/sample', locals: {form_input: self, submitted_form_response: SubmittedFormResponse.new(form_input_id: id)}
    )
  end
  # after_update_commit { broadcast_replace_to "dyna_forms" }
  after_destroy_commit do
    broadcast_remove_to("dyna_form_#{dyna_form.id}_form_input_samples",
      target: "form_input_#{id}_sample"
    )
  end

  def parsed_additional_attributes
    current_attrs = additional_attributes || ''
    JSON.parse(current_attrs) rescue current_attrs.split(',')
  end

  private

  def has_additional_attributes?
    return unless input_type.allows_additional_attributes?

    self.errors.add(:additional_attributes, "required for select option, checkbox, or radio select") unless additional_attributes.present?
  end
end
