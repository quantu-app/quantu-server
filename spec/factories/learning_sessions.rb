# frozen_string_literal: true

FactoryBot.define do
  factory :learning_session do
    data { nil }
    association :user
    association :learnable
  end
end
