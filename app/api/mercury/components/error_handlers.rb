# frozen_string_literal: true

module Mercury
  module Components
    module ErrorHandlers
      extend ActiveSupport::Concern

      included do
        rescue_from(Pundit::AuthorizationNotPerformedError) do |_e|
          error!({ errors: ['authorization not performed'] }, 500)
        end

        rescue_from(Pundit::NotAuthorizedError) do |e|
          policy_name = e.policy.class.to_s.underscore
          message = I18n.t("#{policy_name}.#{e.query}", scope: 'pundit', default: :default)
          error!({ errors: [message] }, 401)
        end

        rescue_from(ActiveRecord::RecordNotFound) do |e|
          message = Rails.env.production? ? 'resource could not be found' : e.message
          error!({ errors: [message] }, 404)
        end
      end
    end
  end
end
