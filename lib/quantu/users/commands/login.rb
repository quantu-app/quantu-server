# frozen_string_literal: true

module QuantU
  module Users
    module Commands
      class Login < ::QuantU::Core::BaseCommand
        validator(Users::Contracts::Login)

        step :validate
        step :login_as_user

        def login_as_user(input)
          user = User.find_by(email: input[:email])

          if user&.authenticate(input[:password])
            token = Core::Utils::JsonWebToken.encode({ user_id: user.id })
            exp_time = Core::Utils::JsonWebToken.create_expires_at

            Success(Entities::LoginToken.new(token:,
                                             expires_at: exp_time.to_s))
          else
            Failure(Core::Entities::StringErrorsList.new(errors: ['authentication failed']))
          end
        end
      end
    end
  end
end
