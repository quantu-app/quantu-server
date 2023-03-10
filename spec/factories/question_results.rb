# frozen_string_literal: true

FactoryBot.define do
  factory :question_result do
    data { { user_response: 42 } }
    association :question
    association :user
    association :study_session
  end
end
