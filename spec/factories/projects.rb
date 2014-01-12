# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:title){|n| "MyString#{n}" }
    short_description "MyString"
    media_url "http://www.youtube.com/watch?v=EDUpiVwi6lw"
    extended_description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vel sem eu lectus dictum ornare amet."
    funding_goal 1522.3
    funding_duration 90
    category "MyString"
    tags "MyString"
    association :user
  end
end
