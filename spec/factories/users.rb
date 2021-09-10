FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password 'testpassword'
  end
end