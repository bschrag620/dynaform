class User < ApplicationRecord
  has_secure_password

  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalid"  },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 254 },
    presence: true

  has_many :sessions

  has_many :user_forms

  #
  # Checks if the session is valid for the user
  #
  # @param session_id [String] the uuid of the session
  #
  # @return [Boolean]
  #
  def has_valid_session?(session_id)
    sessions.valid.find_by(id: session_id).present?
  end

  #
  # Logs the user in by creating a new session
  #
  # @return [Session]
  #
  def login!
    Session.create!(user: self, expires_at: 1.week.from_now)
  end

  #
  # Logs the user out - can optionally expire all sessions for the user
  #
  # @param session_id [String] the uuid of the session
  # @param all_sessions [Boolean] optional bit for expiring all sessions - defaults to false
  #
  # @return [void]
  #
  def logout!(session_id, all_sessions: false)
    qry = all_sessions ? sessions.valid : sessions.where(id: session_id)
    qry.update_all(expires_at: Time.now)
  end
end
