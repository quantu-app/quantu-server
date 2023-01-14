# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes API', type: :request do
  let(:user) do
    User.create(
      username: 'test',
      email: 'test@test.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end
  let(:user2) { create(:user, username: 'seconduser') }
  let(:jwt_token) do
    QuantU::Utils::JsonWebToken.encode({ user_id: user.id })
  end
  let(:headers) do
    {
      "Content-Type" => "application/json", 
      "Authorization" => "Bearer #{jwt_token}"
    }
  end
  describe "list" do

    it "returns all quizzes that belong to the user, and only those quizzes that belong to him." do 
        quizzes = create_list(:quiz, 2, user: user)
        create_list(:quiz, 3, user: user2)

        get("/api/quizzes", headers: headers, as: :json)
        expect(json.length).to be(2)
        expect(json.map { |x| x["name"] }).to match_array(quizzes.map { |x| x["name"] })
    end
  end

  describe "create" do
    it "creates a new quiz when given a valid name parameter" do
      post("/api/quizzes", params: { name: "Test Quiz"}, headers: headers, as: :json)

      expect(response).to have_http_status(:created)
      expect(json['name']).to eq('Test Quiz')
      expect(json['uri']).to eq('test-quiz')
    end
  end

  describe "show" do
    it "returns a quiz that belongs to the user" do
      quiz = create(:quiz, user: user)

      get("/api/quizzes/#{quiz.id}", headers: headers, as: :json)
      expect(json["id"]).to eq(quiz.id)
    end

    it "returns an error when trying to access a quiz that does not belong to the user" do
      quiz = create(:quiz, user: user2)

      get("/api/quizzes/#{quiz.id}", headers: headers, as: :json)

      expect(response).to have_http_status(:unauthorized)
      expect(json).to have_key("errors")
      expect(json["errors"]).to eq(["You cannot perform this action."])
    end
  end

  describe "update" do
    it 'updates a quiz that belongs to a user' do
      quiz = create(:quiz, name: 'a test name', user: user)

      patch("/api/quizzes/#{quiz.id}", params: { name: "another test name"}, headers: headers, as: :json)
      expect(json['name']).to eq('another test name')
    end
  end

  describe "delete" do
    it 'deletes a quiz that belongs to a user' do
      quiz = create(:quiz, user: user)
      original_id = quiz.id

      delete("/api/quizzes/#{quiz.id}", headers: headers, as: :json)
      expect(response).to have_http_status(:no_content)
      expect {
        Quiz.find(original_id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'will not delete a quiz that belongs to another user' do
      other_users_quiz = create(:quiz, user: user2)
      delete("/api/quizzes/#{other_users_quiz.id}", headers: headers, as: :json)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end