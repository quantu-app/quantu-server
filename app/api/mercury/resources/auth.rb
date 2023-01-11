module Mercury
  module Resources
    class Auth < API
      namespace :auth do

        desc 'login to fetch a new JWT token'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User Password'
        end
        post '/login' do
          @user = User.find_by(email: params[:email])
          if @user&.authenticate(params[:password])
            token = QuantU::Utils::JsonWebToken.encode({ user_id: @user.id })
            exp_time = QuantU::Utils::JsonWebToken.create_expires_at
            present({token:, exp: exp_time.iso8601}, with: Mercury::Entities::Token)
          else
            error!({ error: 'authentication failed' }, 401)
          end
        end

        desc 'get the current user'
        get '/me' do
          @user = current_user
          present(@user, with: Mercury::Entities::User)
        end
      end
    end
  end
end