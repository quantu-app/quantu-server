module Mercury
  module Components
    module ErrorHandlers
      extend ActiveSupport::Concern

      included do
        rescue_from(Pundit::AuthorizationNotPerformedError) do |e|
          error!({errors: ['authorization not performed'] }, 500)
        end

        rescue_from(Pundit::NotAuthorizedError) do |e|
          policy_name = e.policy.class.to_s.underscore
          message = I18n.t("#{policy_name}.#{e.query}", scope: "pundit", default: :default)
          error!({ errors: [message] }, 401)
        end

        rescue_from(ActiveRecord::RecordNotFound) do |_exception|
          error!({ errors: ["resource not found"] }, 404)
        end
      end
    end
  end
end
