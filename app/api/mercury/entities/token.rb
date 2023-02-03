# frozen_string_literal: true

module Mercury
  module Entities
    class Token < Grape::Entity
      def self.entity_name = 'Token'

      format_with(:iso_timestamp, &:iso8601)

      expose :token, documentation: { desc: 'Token', type: 'string', required: true }

      with_options(format_with: :iso_timestamp) do
        expose :expires_at,
               documentation: { desc: 'Expiration Date', type: 'string', format: 'date-time', required: true }
      end
    end
  end
end
