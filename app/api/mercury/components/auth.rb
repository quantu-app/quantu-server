module Mercury
  module Components
    module Auth
      extend ActiveSupport::Concern

      included do

        helpers do
          include Pundit::Authorization
          def current_user
            @current_user ||= authorize_request
          end
    
          def authenticate!
            error!({errors: '401 Unauthorized'}, 401) unless current_user
          end

          def authorize_request
            header = headers['Authorization']
            header = header.split(' ').last if header
            begin
              @decoded = QuantU::Utils::JsonWebToken.decode(header)
              @current_user = User.find(@decoded[:user_id])
              return @current_user
            rescue ActiveRecord::RecordNotFound => e
              error!({ errors: e.message }, 401)
            rescue JWT::DecodeError => e
              error!({ errors: e.message }, 401)
            end
          end
        end
      end
    end
  end
end
