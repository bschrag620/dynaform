class DynaForm < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :form_inputs

  after_create_commit { broadcast_append_to "dyna_forms" }
  after_update_commit { broadcast_replace_to "dyna_forms" }
  after_destroy_commit { broadcast_remove_to "dyna_forms" }
end
