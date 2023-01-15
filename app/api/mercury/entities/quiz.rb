module Mercury
  module Entities
    class Quiz < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id, documentation: { type: 'integer', required: true }
      expose :name, documentation: { type: 'string', required: true }
      expose :uri, documentation: { type: 'string', required: true }
      
      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'string', format: 'date-time', required: true }
      end
    end
  end
end