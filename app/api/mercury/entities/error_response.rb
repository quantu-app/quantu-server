module Mercury
  module Entities
    class ErrorResponse < Grape::Entity
      expose :errors, documentation: { type: Array[String], is_array: true, required: true }
    end
  end
end