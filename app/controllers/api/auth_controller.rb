# frozen_string_literal: true

module Api
  class AuthController < BaseController
    skip_before_action :authorize_request, only: [:login]

    def login
      @user = User.find_by(email: params[:email])
      if @user&.authenticate(params[:password])
        token = QuantU::Utils::JsonWebToken.encode({ user_id: @user.id })
        exp_time = QuantU::Utils::JsonWebToken.create_expires_at
        render(json: { token:, exp: exp_time.iso8601, username: @user.username }, status: :ok)
      else
        render(json: { error: 'authenticated failed' }, status: :unauthorized)
      end
    end

    private

    def login_params
      params.require(:email)
      params.require(:password)
    end
  end
end
