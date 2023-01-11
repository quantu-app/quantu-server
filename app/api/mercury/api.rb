require 'grape-swagger'

module Mercury
  class API < Grape::API
    prefix 'api'
    format :json

    # setup
    include Mercury::Components::Auth
    include Mercury::Components::ErrorHandlers

    # resources
    mount Mercury::Resources::Auth
    mount Mercury::Resources::Quizzes
    mount Mercury::Resources::Questions

    add_swagger_documentation if Rails.env.development?
  end
end