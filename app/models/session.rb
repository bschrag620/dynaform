class Session < ApplicationRecord
  belongs_to :user

  scope :valid, -> { where('expires_at > current_timestamp') }
end
