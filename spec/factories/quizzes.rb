# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    name { "#{Faker::Book.title}-#{Faker::Internet.uuid}" }
    uri { Faker::Internet.uuid }

    association :user
  end
end
