class SubmittedForm < ApplicationRecord
  belongs_to :dyna_form

  has_many :submitted_form_responses
end
