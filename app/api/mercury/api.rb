# frozen_string_literal: true

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

    if Rails.env.development?
      add_swagger_documentation(mount_path: '/docs',
                                info: {
                                  title: 'QuantU Services API'
                                },
                                security_definitions: {
                                  bearer_auth: {
                                    type: 'apiKey',
                                    name: 'Authorization',
                                    in: 'header'
                                  }
                                },
                                security: [
                                  {
                                    bearer_auth: []
                                  }
                                ])
    end
  end
end
