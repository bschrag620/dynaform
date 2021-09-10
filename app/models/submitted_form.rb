class SubmittedForm < ApplicationRecord
  belongs_to :user_form

  has_many :submitted_form_responses
end
