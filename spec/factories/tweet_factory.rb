# This will guess the Tweet class

FactoryBot.define do
    factory :tweet do
        tweet { "Test Tweet !!!" }
        user
    end
end
