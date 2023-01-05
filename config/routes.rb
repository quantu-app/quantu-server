# frozen_string_literal: true

Rails.application.routes.draw do
  # authentication
  scope module: :api, path: '/api' do
    scope path: '/auth' do
      post 'login', to: 'auth#login'
      get 'me', to: 'users#me'
    end

    resources :quizzes, only: %i[index show create update destroy] do
      resources :questions, only: %i[index show create update destroy]
    end
  end
end
