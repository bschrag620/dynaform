class DynaForm < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validate :is_unlocked?

  belongs_to :user

  has_many :form_inputs

  after_create_commit do
    broadcast_prepend_to "user_#{Current.user.id}_dyna_forms",
      target: "user_#{Current.user.id}_dyna_forms" if Current.user
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

  def publish
    update(published: true, locked: true)
  end

  def unpublish
    update(published: false)
  end

  private
  def is_unlocked?
    changed_attrs = changed_attributes.except(:published, :locked)
    self.errors.add("DynaForm", "is locked, further changes are not permitted") if self.locked && changed_attrs.any?
  end
end
