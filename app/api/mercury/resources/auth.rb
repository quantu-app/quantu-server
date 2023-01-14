module Mercury
  module Resources
    class Auth < API
      namespace :auth do

        desc 'login to fetch a new JWT token', 
          success: { code: 200, model: Mercury::Entities::Token },
          failure: [
            { code: 401, model: Mercury::Entities::ErrorResponse }
          ]
        params do
          requires :email, type: String, desc: 'User email', documentation: { param_type: 'body' }
          requires :password, type: String, desc: 'User Password', documentation: { param_type: 'body' }
        end
        post '/login' do
          @user = User.find_by(email: params[:email])
          if @user&.authenticate(params[:password])
            token = QuantU::Utils::JsonWebToken.encode({ user_id: @user.id })
            exp_time = QuantU::Utils::JsonWebToken.create_expires_at
            present({token:, exp: exp_time.iso8601}, with: Mercury::Entities::Token)
          else
            error!({ errors: ['authentication failed'] }, 401)
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