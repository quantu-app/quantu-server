# frozen_string_literal: true

module Mercury
  module Entities
    class ErrorResponse < Grape::Entity
      # TODO: find a non-hacky way to set the model name for openapi / swagger documentation generation.
      def self.entity_name = 'ErrorResponse'

      expose :errors, documentation: { type: Array[String], is_array: true, required: true }
    end
  end
end
