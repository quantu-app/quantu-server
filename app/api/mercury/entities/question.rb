module Mercury
  module Entities
    class Question < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id, documentation: { type: 'integer', required: true }
      expose :name, documentation: { type: 'string', required: true }
      expose :uri, documentation: { type: 'string', required: true }
      expose :question_type, documentation: { type: 'string', required: true }
      expose :item_order, documentation: { type: 'integer', required: true }
      expose :data, documentation: { type: 'object', required: true }
      
      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'string', format: 'date-time', required: true }
      end
    end
  end
end