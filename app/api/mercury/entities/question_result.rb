# frozen_string_literal: true

module Mercury
  module Entities
    class QuestionResult < Grape::Entity
      def self.entity_name = 'QuestionResult'

      format_with(:iso_timestamp, &:iso8601)

      # attribs
      expose :id, documentation: { type: 'Integer', desc: 'ID', required: true }
      expose :data, documentation: { type: 'object', desc: 'Data', required: true }

      # relations
      expose :user_id, documentation: { type: 'Integer', desc: 'User Id', required: true }
      expose :question_id, documentation: { type: 'Integer', desc: 'Question Id', required: true }

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', format: 'date-time', required: true }
        expose :updated_at, documentation: { type: 'string', format: 'date-time', required: true }
      end
    end
  end
end
