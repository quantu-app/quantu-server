# frozen_string_literal: true

module Mercury
  module Entities
    class StudySession < Grape::Entity
      def self.entity_name = 'StudySession'

      format_with(:iso_timestamp, &:iso8601)

      expose :data, documentation: { type: 'object', desc: 'Data', required: true }
      expose :user_id, documentation: { type: 'Integer', desc: 'User Id', required: true }
      expose :learnable_resource_type, proc: proc { |model, _opts|
        model.learnable_resource.learnable_type
      }, documentation: { type: 'string',
                          values: %w[Quiz],
                          required: true,
                          desc: 'Type of learnable resource the Question belongs to' }
      expose :learnable_resource, proc: proc { |model, _opts|
        learnable_model = model.learnable_resource.learnable
        case model.learnable_resource.learnable_type.to_s
        when 'Quiz'
          ::Mercury::Entities::Quiz.represent(learnable_model, only: %w[id name uri])
        end
      }, documentation: { type: 'Integer', desc: 'Learnable Resource Id', required: true }

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'string', format: 'date-time', required: true }
      end
    end
  end
end
