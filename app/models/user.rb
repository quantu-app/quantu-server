# frozen_string_literal: true

class User < ApplicationRecord
  # plugins
  has_secure_password

  # validations
  validates :username, uniqueness: true, length: { minimum: 3 }
  validates :email, uniqueness: true, email: { mode: :strict, require_fqdn: true }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:password_digest] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }
end
