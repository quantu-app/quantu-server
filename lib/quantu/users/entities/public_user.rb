# frozen_string_literal: true

module QuantU
  module Users
    module Entities
      class PublicUser < Dry::Struct
        attribute :username, Core::Types::String
      end
    end
  end
end
