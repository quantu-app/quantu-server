# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    question_type { 'flash_card' }
    association :learnable_resource, factory: :learnable_quiz
    association :user
  end
end
