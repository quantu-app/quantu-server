# frozen_string_literal: true

module QuantU
  module Users
    module Contracts
      class Login < Dry::Validation::Contract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end

        rule(:email) do
          key.failure('has invalid format') unless EmailValidator.valid?(value)
        end

        rule(:password) do
          key.failure('too short') unless value.length >= 6
        end
      end
    end
  end
end
