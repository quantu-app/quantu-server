# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions API', type: :request do
  let(:user) do
    User.create(
      username: 'test3',
      email: 'test3@test3.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end
  let(:user2) { create(:user, username: 'seconduser3') }
  let(:jwt_token) do
    QuantU::Utils::JsonWebToken.encode({ user_id: user.id })
  end
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{jwt_token}"
    }
  end
  let(:quiz) do
    Quiz.create(user:, name: 'Test Quiz 1')
  end
  let(:quiz2) do
    create(:quiz, user: user2)
  end
  describe 'list' do
    it 'get all questions that belong a quiz' do
      user_questions = [
        Question.create(user:, learnable_resource_id: quiz.id, question_type: 'flash_card'),
        Question.create(user:, learnable_resource_id: quiz.id, question_type: 'flash_card')
      ]

      get("/api/quizzes/#{quiz.id}/questions", headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json.length).to be(2)
      expect(json.pluck('name')).to match_array(user_questions.pluck('name'))
    end

    it 'get all questions that belong a user' do
      user_questions = create_list(:question, 2, user:, learnable_resource: quiz)

      get('/api/questions', headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json.length).to be(2)
      expect(json.pluck('name')).to match_array(user_questions.pluck('name'))
      expect(json.pluck('user_id').uniq.first).to eq(user.id)
    end
  end

  describe 'create' do
    it 'creates a new question when given valid data' do
      post("/api/quizzes/#{quiz.id}/questions", params: {
             name: 'Test Question',
             data: {},
             question_type: 'flash_card'
           }, headers:, as: :json)

      expect(response).to have_http_status(:created)
      expect(json['name']).to eq('Test Question')
      expect(json['uri']).to eq('test-question')
      expect(json['question_type']).to eq('flash_card')
    end
  end

  describe 'show' do
    it 'returns a question' do
      question = create(:question, user:, quiz:)

      get("/api/quizzes/#{quiz.id}/questions/#{question.id}", headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(question.id)
    end

    it 'returns an error when trying to access a question that does not belong to the user' do
      quiz2 = create(:quiz, user: user2)
      question2 = create(:question, user: user2, quiz: quiz2)

      get("/api/quizzes/#{quiz2.id}/questions/#{question2.id}", headers:, as: :json)

      expect(response).to have_http_status(:not_found)
      expect(json).to have_key('errors')
      expect(json['errors']).to eq(['resource not found'])
    end
  end

  describe 'update' do
    it 'updates a question that belongs to a user' do
      question = create(:question,
                        name: 'a test name',
                        question_type: 'flash_card',
                        user:,
                        quiz:)

      patch("/api/quizzes/#{quiz.id}/questions/#{question.id}",
            params: {
              name: 'another test name',
              data: { hello: 'world' }
            }, headers:, as: :json)
      expect(json['name']).to eq('another test name')
      expect(json['data']).to have_key('hello')
      expect(json['data']['hello']).to eq('world')
    end
  end

  describe 'delete' do
    it 'deletes a quiz that belongs to a user' do
      question = create(:question, user:, quiz:)
      original_id = question.id

      delete("/api/quizzes/#{quiz.id}/questions/#{question.id}", headers:, as: :json)
      expect(response).to have_http_status(:no_content)
      expect do
        Question.find(original_id)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'will not delete a question that belongs to another user' do
      other_users_quiz = create(:question, user: user2, quiz: quiz2)
      delete("/api/quizzes/#{other_users_quiz.id}", headers:, as: :json)
      expect(response).to have_http_status(:not_found)
    end
  end
end
