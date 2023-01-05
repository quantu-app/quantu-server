FactoryBot.define do
  factory :quiz do
    name { Faker::Book.title }
    position { 0 }

    association :user
  end
end