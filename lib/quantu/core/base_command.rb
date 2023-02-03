# frozen_string_literal: true

module QuantU
  module Core
    class BaseCommand
      include Dry::Transaction

      def self.validator(klass)
        @@klass = klass
      end

      def self.call(...)
        new.call(...)
      end

      def validate(input)
        klass = @@klass.new
        result = klass.call(input)
        if result.success?
          Success(result.values)
        else
          Failure(result.errors)
        end
      end
    end
  end
end
