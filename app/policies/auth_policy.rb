# frozen_string_literal: true

class AuthPolicy

  def initialize(user, _record)
    @user = user
  end

  def login?
    true
  end

  def me?
    user.present?
  end

end