# This will guess the User class

FactoryBot.define do
    factory :user do
      # user_id { 1 }
      name { "Test User" }
      sequence(:username)  {|n| "testuser#{rand(n)}" }
      sequence(:email) { |n| "test.user#{rand(n)}@gmail.com" }
      password { '12345678' }
      password_confirmation { '12345678' }
    end
end
