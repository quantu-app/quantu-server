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
    QuantU::Core::Utils::JsonWebToken.encode({ user_id: user.id })
  end
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{jwt_token}"
    }
  end
  let(:quiz) do
    Quiz.create!(user:, name: 'Test Quiz 1')
  end
  let(:quiz2) do
    create(:quiz, user: user2)
  end
  describe 'list' do
    it 'get all questions that belong a quiz' do
      user_questions = [
        Question.create!(user:, learnable_resource: quiz.learnable_resource, question_type: 'flash_card'),
        Question.create!(user:, learnable_resource: quiz.learnable_resource, question_type: 'flash_card')
      ]
      get("/api/questions?quiz_id=#{quiz.id}", headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json.length).to be(2)
      expect(json.pluck('name')).to match_array(user_questions.pluck('name'))
    end

    it 'get all questions that belong a user' do
      quiz = Quiz.create!(user:, name: 'Test Quiz 1')
      user_questions = [
        Question.create!(user:, learnable_resource: quiz.learnable_resource, question_type: 'flash_card'),
        Question.create!(user:, learnable_resource: quiz.learnable_resource, question_type: 'flash_card')
      ]

      get('/api/questions', headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json.length).to be(2)
      expect(json.pluck('name')).to match_array(user_questions.pluck('name'))
      expect(json.pluck('user_id').uniq.first).to eq(user.id)
    end
  end

  describe 'create' do
    it 'creates a new question for a Quiz when given valid data' do
      post('/api/questions', params: {
             quiz_id: quiz.id,
             name: 'Test Question',
             data: {},
             question_type: 'flash_card'
           }, headers:, as: :json)

      expect(response).to have_http_status(:created)
      expect(json['name']).to eq('Test Question')
      expect(json['uri']).to eq('test-question')
      expect(json['learnable_resource_type']).to eq('Quiz')
      expect(json['learnable_resource_id']).to eq(quiz.id)
      expect(json['question_type']).to eq('flash_card')
    end
  end

  describe 'show' do
    it 'returns a question belonging to a Quiz' do
      question = create(:question, user:, quiz:)

      get("/api/questions/#{question.id}?quiz_id=#{quiz.id}", headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json.keys).to match_array(%w[id name uri learnable_resource_type learnable_resource_id data item_order
                                          question_type user_id created_at updated_at])
      expect(json['id']).to eq(question.id)
      expect(json['name']).to eq(question.name)
      expect(json['learnable_resource_type']).to eq('Quiz')
      expect(json['learnable_resource_id']).to eq(quiz.id)
    end

    it 'returns an error when trying to access a question that does not belong to the user' do
      quiz2 = create(:quiz, user: user2)
      question2 = create(:question, user: user2, quiz: quiz2)

      get("/api/questions/#{question2.id}?quiz_id=#{quiz2.id}", headers:, as: :json)

      expect(response).to have_http_status(:not_found)
      expect(json).to have_key('errors')
      expect(json['errors'].first).to match(/\ACouldn't find Quiz/)
    end
  end

  describe 'update' do
    it 'updates a question that belongs to a user' do
      question = create(:question,
                        name: 'a test name',
                        question_type: 'flash_card',
                        user:,
                        quiz:)

      patch("/api/questions/#{question.id}",
            params: {
              quiz_id: quiz.id,
              name: 'another test name',
              data: { hello: 'world' }
            }, headers:, as: :json)
      expect(json['name']).to eq('another test name')
      expect(json['data']).to have_key('hello')
      expect(json['data']['hello']).to eq('world')
    end
  end

  describe 'delete' do
    it 'deletes a question that belongs to a user' do
      question = create(:question, user:, quiz:)
      original_id = question.id

      delete("/api/questions/#{question.id}?quiz_id=#{quiz.id}", headers:, as: :json)
      expect(response).to have_http_status(:no_content)
      expect do
        Question.find(original_id)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'will not delete a question that belongs to another user' do
      other_users_question = create(:question, user: user2, quiz: quiz2)
      delete("/api/questions/#{other_users_question.id}?quiz_id=#{quiz2.id}", headers:, as: :json)
      expect(response).to have_http_status(:not_found)
    end
  end
end
