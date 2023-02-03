# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question Results API', type: :request do
  let(:user) do
    User.create(
      username: 'test4',
      email: 'test4@test4.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end
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
    create(:quiz, user:)
  end
  let(:question) do
    lr = quiz.learnable_resource
    lr.questions.create!(user:,
                         name: 'Question Results Test Q',
                         question_type: 'flash_card',
                         uri: 'question-results-test-question')
  end
  describe 'list' do
    it 'get all questions results that belong a question' do
      question_results = [
        QuestionResult.create!(user:, question:),
        QuestionResult.create!(user:, question:)
      ]

      get("/api/question_results?question_id=#{question.id}", headers:, as: :json)

      expect(response).to have_http_status(:ok)
      expect(json.length).to be(2)
    end

    # it 'get all question results that belong a user' do
    #   user_questions = create_list(:question, 2, user:, quiz:)

    #   get('/api/question_results', headers:, as: :json)

    #   expect(response).to have_http_status(:ok)
    #   expect(json.length).to be(2)
    #   expect(json.pluck('name')).to match_array(user_questions.pluck('name'))
    #   expect(json.pluck('user_id').uniq.first).to eq(user.id)
    # end
  end

  describe 'create' do
    # it 'creates a new question result when given valid data' do
    #   post("/api/quizzes/#{quiz.id}/questions", params: {
    #          name: 'Test Question',
    #          data: {},
    #          question_type: 'flash_card'
    #        }, headers:, as: :json)

    #   expect(response).to have_http_status(:created)
    #   expect(json['name']).to eq('Test Question')
    #   expect(json['uri']).to eq('test-question')
    #   expect(json['question_type']).to eq('flash_card')
    # end
  end

  describe 'show' do
    it 'returns a question result' do
      # question = create(:question, user:, quiz:)

      # get("/api/quizzes/#{quiz.id}/questions/#{question.id}", headers:, as: :json)

      # expect(response).to have_http_status(:ok)
      # expect(json['id']).to eq(question.id)
    end

    # it 'returns an error when trying to access a question that does not belong to the user' do
    #   quiz2 = create(:quiz, user: user2)
    #   question2 = create(:question, user: user2, quiz: quiz2)

    #   get("/api/quizzes/#{quiz2.id}/questions/#{question2.id}", headers:, as: :json)

    #   expect(response).to have_http_status(:not_found)
    #   expect(json).to have_key('errors')
    #   expect(json['errors']).to eq(['resource not found'])
    # end
  end
end
