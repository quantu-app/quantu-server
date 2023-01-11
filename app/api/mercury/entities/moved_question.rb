module Mercury
  module Entities
    class MovedQuestion < Grape::Entity
      expose :moved_question, using: Mercury::Entities::Question
      expose :other_questions, using: Mercury::Entities::Question
    end
  end
end