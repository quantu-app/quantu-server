# frozen_string_literal: true

module QuantU
  module Users
    module Entities
      class SelfUser < Dry::Struct
        attribute :username, Core::Types::String
        attribute :email, Core::Types::String
        attribute :updated_at, Core::Types::DateTime
        attribute :created_at, Core::Types::DateTime
      end
    end
  end
end
