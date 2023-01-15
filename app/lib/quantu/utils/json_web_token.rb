# frozen_string_literal: true

module QuantU
  module Utils
    class JsonWebToken
      SECRET_KEY ||= ENV.fetch("SECRET_KEY")
      DEFAULT_EXPIRES_AT ||= 24.hours

      def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
      end

      def self.decode(token)
        decoded_token = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new(decoded_token)
      end

      def self.create_expires_at
        Time.now + ENV.fetch("JWT_EXPIRES_AT", DEFAULT_EXPIRES_AT).to_i
      end
    end
  end
end
