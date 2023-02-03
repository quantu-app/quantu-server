# frozen_string_literal: true

module QuantU
  module Users
    module Entities
      class PublicUser < Dry::Struct
        attribute :username, Types::String
      end
    end
  end
end
