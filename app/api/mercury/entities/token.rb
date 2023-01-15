module Mercury
  module Entities
    class Token < Grape::Entity
      expose :token, documentation: { type: 'string', required: true }
      expose :exp, documentation: { type: 'integer', required: true }
    end
  end
end