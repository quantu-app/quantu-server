# frozen_string_literal: true

module Api
  class UsersController < BaseController
    def me
      render(json: @current_user.as_json(only: %i[username email]), status: :ok)
    end
  end
end
