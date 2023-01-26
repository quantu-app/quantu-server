# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    question_type { 'flash_card' }
    association :quiz
    association :user
  end
end
