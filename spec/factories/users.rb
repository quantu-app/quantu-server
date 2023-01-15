FactoryBot.define do
  factory :user do
    username { Faker::Internet.uuid }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end