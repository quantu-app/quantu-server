module Mercury
  module Entities
    class Question < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :name
      expose :uri
      expose :question_type
      expose :item_order
      expose :data
      
      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end