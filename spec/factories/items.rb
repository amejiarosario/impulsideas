# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    title "MyString"
    description "MyText"
    price "9.99"
    stock 1
    user nil
  end
end
