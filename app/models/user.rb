class User < ApplicationRecord
  has_secure_password
  has_secure_token :session_token

  encrypts :password_digest
  encrypts :session_token, deterministic: true

  normalizes :username, with: ->(v) { v.to_s.strip.downcase }

  validates :username, presence: true, uniqueness: true
end
