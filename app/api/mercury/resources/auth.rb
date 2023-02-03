# frozen_string_literal: true

module Mercury
  module Resources
    class Auth < API
      namespace :auth do
        desc 'Login and return a new JWT access token',
             success: { code: 200, model: Mercury::Entities::Token },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :email, type: String, desc: 'User email', documentation: { param_type: 'body' }
          requires :password, type: String, desc: 'User Password', documentation: { param_type: 'body' }
        end
        post '/login' do
          QuantU::Users::Commands::Login.new.call(params) do |result|
            result.success do |token_info|
              present(token_info, with: Mercury::Entities::Token)
            end

            result.failure :validate do |validation|
              error!({ errors: validation.to_a.map(&:to_h) }, 422)
            end

            result.failure do |error|
              error!(error, 401)
            end
          end
        end

        before { authenticate! }
        desc 'get the current user',
             success: { code: 200, model: Mercury::Entities::User },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse }
             ]
        get '/me' do
          @user = current_user
          present(@user, with: Mercury::Entities::User)
        end
      end
    end
  end
end
