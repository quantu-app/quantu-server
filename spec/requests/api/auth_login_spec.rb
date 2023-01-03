# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Auth login', type: :request do
  describe 'POST /api/auth/login' do
    let(:user) do
      User.create(
        username: 'test',
        email: 'test@test.com',
        password: '123456',
        password_confirmation: '123456'
      )
    end

    it 'logs in a user when given correct email and password' do
      post('/api/auth/login', params: { email: user.email, password: '123456' })

      expect(response).to have_http_status(:ok)
      expect(json['username']).to eq('test')
      expect(json['token']).to_not be_empty
    end

    it 'fails to login a user when given an incorrect email or password' do
      # invalid email
      post('/api/auth/login', params: { email: 'not-an-email@test.com', password: '123456' })

      expect(response).to have_http_status(:unauthorized)
      expect(json['error']).to eq('authenticated failed')

      # invalid password
      post('/api/auth/login', params: { email: user.email, password: '654321' })

      expect(response).to have_http_status(:unauthorized)
      expect(json['error']).to eq('authenticated failed')
    end
  end
end
