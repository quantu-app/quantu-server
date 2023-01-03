# frozen_string_literal: true

module Api
  class AuthController < BaseController
    skip_before_action :authorize_request, only: [:login]

    def login
      @user = User.find_by(email: login_params[:email])
      if @user&.authenticate(params[:password])
        token = QuantU::Utils::JsonWebToken.encode({ user_id: @user.id })
        time = Time.now + 24.hours.to_i
        render(json: { token:, exp: time.iso8601, username: @user.username }, status: :ok)
      else
        render(json: { error: 'authenticated failed' }, status: :unauthorized)
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end
