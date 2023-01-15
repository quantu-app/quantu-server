module Mercury
  module Entities
    class Question < Grape::Entity
      def self.entity_name; 'Question'; end

      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id, documentation: { type: 'Integer', desc: 'ID', required: true }
      expose :name, documentation: { type: 'String', desc: 'Name', required: true }
      expose :uri, documentation: { type: 'String', desc: 'URI', format: 'uri', required: true }
      expose :question_type, documentation: { type: 'string', values: %w[flash_card], required: true, desc: 'Type of Question' }
      expose :item_order, documentation: { type: 'Integer', desc: 'Item Order', required: true }
      expose :data, documentation: { type: 'object', desc: 'Data', required: true }
      
      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'string', format: 'date-time', required: true }
      end
    end
  end
end