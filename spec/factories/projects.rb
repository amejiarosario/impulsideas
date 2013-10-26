# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "MyString"
    short_description "MyString"
    extended_description "MyText"
    funding_goal 1.5
    funding_duration 1
    category "MyString"
    tags "MyString"
    association :user
  end
end
