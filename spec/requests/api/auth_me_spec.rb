# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Auth me', type: :request do
  describe 'GET /api/auth/me' do
    let(:user) do
      User.create(
        username: 'test',
        email: 'test@test.com',
        password: '123456',
        password_confirmation: '123456'
      )
    end
    let(:jwt_token) do
      QuantU::Utils::JsonWebToken.encode({ user_id: user.id })
    end

    it 'shows the current user if provided a valid jwt token' do
      get('/api/auth/me', headers: { 'Authorization' => "Bearer #{jwt_token}" }, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json['username']).to eq('test')
      expect(json['email']).to eq('test@test.com')
    end

    it 'returns unauthorized if provided an invalid jwt token' do
      get('/api/auth/me', headers: { 'Authorization' => 'Bearer invalid' }, as: :json )

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
