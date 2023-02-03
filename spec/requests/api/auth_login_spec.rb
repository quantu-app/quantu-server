# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Auth login', type: :request do
  describe 'POST /api/auth/login' do
    let(:user) do
      User.create(
        username: 'test2',
        email: 'test2@test2.com',
        password: '123456',
        password_confirmation: '123456'
      )
    end
    let(:headers) do
      {
        'Content-Type' => 'application/json'
      }
    end

    it 'logs in a user when given correct email and password' do
      post('/api/auth/login', params: { email: user.email, password: '123456' }, headers:, as: :json)
      expect(response).to have_http_status(:created)
      expect(json['token']).to_not be_empty
      expect(json['expires_at']).to_not be_empty
    end

    it 'fails to login a user when given an incorrect email or password' do
      # invalid email
      post('/api/auth/login', params: { email: 'not-an-email@test.com', password: '123456' }, headers:,
                              as: :json)

      expect(response).to have_http_status(:unauthorized)
      expect(json['errors']).to eq(['authentication failed'])

      # invalid password
      post('/api/auth/login', params: { email: user.email, password: '654321' }, headers:, as: :json)
      expect(response).to have_http_status(:unauthorized)
      expect(json['errors']).to eq(['authentication failed'])
    end
  end
end
