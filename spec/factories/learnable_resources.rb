# frozen_string_literal: true

FactoryBot.define do
  factory :learnable_quiz, class: 'LearnableResource' do
    association :user
    association :learnable, factory: :quiz
  end
end
