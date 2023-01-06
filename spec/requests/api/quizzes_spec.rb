# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Quizzes', type: :request do
  let(:user) do
    User.create(
      username: 'test',
      email: 'test@test.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end
  let(:user2) { create(:user) }
  let(:jwt_token) do
    QuantU::Utils::JsonWebToken.encode({ user_id: user.id })
  end
  let(:headers) do
    {
      "Content-Type" => "application/json", 
      "Authorization" => "Bearer #{jwt_token}"
    }
  end
  describe "GET /api/quizzes" do

    it "returns all quizzes that belong to the user, and only those quizzes that belong to him." do 
        quizzes = create_list(:quiz, 2, user: user)
        create_list(:quiz, 3, user: user2)

        get("/api/quizzes", headers: headers, as: :json)
        expect(json.length).to be(2)
        expect(json.map { |x| x["name"] }).to match_array(quizzes.map { |x| x["name"] })
    end
  end

  describe "GET /api/quizzes/:id" do
    it "returns a quiz that belongs to the user" do
      quiz = create(:quiz, user: user)

      get("/api/quizzes/#{quiz.id}", headers: headers, as: :json)
      expect(json["id"]).to eq(quiz.id)
    end

    it "returns an error when trying to access a quiz that does not belong to the user" do
      quiz = create(:quiz, user: user2)

      get("/api/quizzes/#{quiz.id}", headers: headers, as: :json)

      expect(response).to have_http_status(:not_found)
      expect(json).to have_key("error")
      expect(json["error"]).to eq("resource not found")
    end
  end
end