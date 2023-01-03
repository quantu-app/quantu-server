# frozen_string_literal: true

Rails.application.routes.draw do
  # authentication
  scope module: :api, path: '/api' do
    scope path: '/auth' do
      post 'login', to: 'auth#login'
      get 'me', to: 'users#me'
    end
  end
end
