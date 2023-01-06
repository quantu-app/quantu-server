FactoryBot.define do
  factory :quiz do
    name { Faker::Book.title }

    association :user
  end
end