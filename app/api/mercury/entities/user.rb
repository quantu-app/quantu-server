module Mercury
  module Entities
    class User < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :email
      expose :username
      
      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end