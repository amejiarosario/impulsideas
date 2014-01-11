# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    amount 1.5
    payment_status 'ACTIVE'
    association :user
    association :project
  end
end
