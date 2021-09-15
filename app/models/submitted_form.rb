class SubmittedForm < ApplicationRecord
  belongs_to :dyna_form

  has_many :submitted_form_responses

  #
  # Marks the submitted form as completed
  #
  # @return [void]
  #
  def complete!
    return if completed?

    update!(completed: true, complete_date: Time.now) if is_complete?
  end

  #
  # Validation check for the submitted form to be complete
  #
  # @return [Boolean]
  #
  def is_complete?
    submitted_form_responses.reduce(true) do |acc, sfr|
      sfr.save
      acc && sfr.errors.empty?
    end
  end
end
