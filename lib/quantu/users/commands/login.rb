# frozen_string_literal: true

module QuantU
  module Users
    module Commands
      class Login < ::QuantU::Core::BaseCommand
        validator(Users::Contracts::Login)

        step :validate
        step :login_as_user

        def login_as_user(input)
          @user = User.find_by(email: input[:email])
          if @user&.authenticate(input[:password])
            token = QuantU::Utils::JsonWebToken.encode({ user_id: @user.id })
            exp_time = QuantU::Utils::JsonWebToken.create_expires_at
            Success({ token:, expires_at: exp_time })
          else
            Failure({ errors: ['authentication failed'] })
          end
        end
      end
    end
  end
end
