# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "user#{n}@example.com" }
    password "Password2013"
  end
end
