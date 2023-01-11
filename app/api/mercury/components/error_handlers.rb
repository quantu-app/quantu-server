module Mercury
  module Components
    module ErrorHandlers
      extend ActiveSupport::Concern

      included do
        rescue_from(Pundit::AuthorizationNotPerformedError) do |e|
          error!({error: 'authorization not performed'}, 500)
        end

        rescue_from(Pundit::NotAuthorizedError) do |e|
          policy_name = e.policy.class.to_s.underscore
          message = I18n.t("#{policy_name}.#{e.query}", scope: "pundit", default: :default)
          error!({ error: message }, 401)
        end

        rescue_from(ActiveRecord::RecordNotFound) do |_exception|
          error!({ error: "resource not found"}, 404)
        end
      end
    end
  end
end
