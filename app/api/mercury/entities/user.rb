module Mercury
  module Entities
    class User < Grape::Entity
      def self.entity_name; 'User'; end

      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id, documentation: { desc: 'ID', type: 'Integer', required: true }
      expose :email, documentation: { desc: 'E-Mail', type: 'String', format: 'email', required: true }
      expose :username, documentation: { desc: 'Username', type: 'String', required: true }
      
      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'String', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'String', format: 'date-time', required: true }
      end
    end
  end
end