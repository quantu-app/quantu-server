# frozen_string_literal: true

FactoryBot.define do
  factory :study_session do
    data { nil }
    association :user
    association :learnable_resource
  end
end
