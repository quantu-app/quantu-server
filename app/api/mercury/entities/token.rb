module Mercury
  module Entities
    class Token < Grape::Entity
      expose :token
      expose :exp
    end
  end
end