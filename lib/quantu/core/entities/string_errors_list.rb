# frozen_string_literal: true

module QuantU
  module Core
    module Entities
      class StringErrorsList < Dry::Struct
        attribute :errors, Core::Types::Array.of(Core::Types::Coercible::String)
      end
    end
  end
end
