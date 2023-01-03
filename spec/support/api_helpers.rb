# frozen_string_literal: true

module ApiHelpers
  def json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include(ApiHelpers)
end
