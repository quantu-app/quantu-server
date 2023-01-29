# frozen_string_literal: true

module Mercury
  module Entities
    class MovedQuestion < Grape::Entity
      def self.entity_name = 'MovedQuestion'

      expose :moved_question, using: Mercury::Entities::Question, documentation: { required: true }
      expose :other_questions, using: Mercury::Entities::Question, documentation: { required: true, is_array: 'true' }
    end
  end
end
