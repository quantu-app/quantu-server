# frozen_string_literal: true

module Mercury
  module Entities
    class Quiz < Grape::Entity
      def self.entity_name = 'Quiz'

      format_with(:iso_timestamp, &:iso8601)

      expose :id, documentation: { desc: 'ID', type: 'Integer', required: true }
      expose :user_id, documentation: { type: 'Integer', desc: 'User Id', required: true }
      expose :learnable_resource_type, proc: proc { |_m, _o| 'Quiz' },
                                       documentation: { type: 'String',
                                                        values: %w[Quiz],
                                                        desc: 'Learnable Resource Type',
                                                        required: true }
      expose :name, documentation: { desc: 'Name', type: 'String', required: true }
      expose :uri, documentation: { desc: 'URI', type: 'String', format: 'uri', required: true }

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'String', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'String', format: 'date-time', required: true }
      end
    end
  end
end
