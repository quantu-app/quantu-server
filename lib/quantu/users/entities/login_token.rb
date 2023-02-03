# frozen_string_literal: true

module QuantU
  module Users
    module Entities
      class LoginToken < Dry::Struct
        attribute :token, Core::Types::String
        attribute :expires_at, Core::Types::Params::DateTime
      end
    end
  end
end
