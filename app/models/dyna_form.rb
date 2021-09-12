class DynaForm < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :form_inputs

  after_create_commit { broadcast_prepend_to "dyna_forms" }
  after_update_commit { broadcast_replace_to "dyna_forms" }
  after_destroy_commit do
    broadcast_remove_to "dyna_forms"
    broadcast_remove_to "dyna_form_window"
  end
end
