# frozen_string_literal: true

Rails.application.routes.draw do
  mount Mercury::API => '/'

  mount Rswag::Ui::Engine => '/api-docs' if Rails.env.development?
end
