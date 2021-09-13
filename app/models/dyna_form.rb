class DynaForm < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :form_inputs

  after_create_commit do
    broadcast_prepend_to "user_#{Current.user.id}_dyna_forms", target: "user_#{Current.user.id}_dyna_forms" if Current.user
  end

  after_update_commit do
    broadcast_replace_to "user_#{Current.user.id}_dyna_forms" if Current.user
  end

  after_destroy_commit do
    if Current.user
      broadcast_remove_to "user_#{Current.user.id}_dyna_forms"
      broadcast_remove_to "user_#{Current.user.id}_dyna_form_window"
    end
  end

  scope :published, -> {
    where(published: true)
  }
end
