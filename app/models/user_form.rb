class UserForm < ApplicationRecord
  belongs_to :user

  has_many :form_inputs
end
