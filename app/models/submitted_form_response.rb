class SubmittedFormResponse < ApplicationRecord
  belongs_to :submitted_form

  belongs_to :form_input
end
