# frozen_string_literal: true

module Api
  class UsersController < BaseController
    def me
      render(json: @current_user.as_json(only: %i[id username email created_at updated_at]), status: :ok)
    end
  end
end
