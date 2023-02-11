# frozen_string_literal: true

module Mercury
  module Entities
    class Question < Grape::Entity
      def self.entity_name = 'Question'

      format_with(:iso_timestamp, &:iso8601)

      expose :id, documentation: { type: 'Integer', desc: 'ID', required: true }
      expose :user_id, documentation: { type: 'Integer', desc: 'User Id', required: true }
      expose :name, documentation: { type: 'String', desc: 'Name', required: false }
      expose :uri, documentation: { type: 'String', desc: 'URI', format: 'uri', required: false }
      expose :learnable_resource_type, proc: proc { |model, _opts|
        model.learnable_resource.learnable_type
      }, documentation: { type: 'string', values: %w[Quiz], required: true, desc: 'Type of learnable resource the Question belongs to' }
      expose :learnable_resource_id, proc: proc { |model, _opts|
        model.learnable_resource.learnable.id
      }, documentation: { type: 'Integer', desc: 'Learnable Resource Id', required: true }
      expose :question_type,
             documentation: { type: 'string', values: %w[flash_card], required: true, desc: 'Type of Question' }
      expose :item_order, documentation: { type: 'Integer', desc: 'Item Order', required: true }
      expose :data, documentation: { type: 'object', desc: 'Data', required: true }

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'string', format: 'date-time', required: true }
      end
    end
  end
end
