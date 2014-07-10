# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  picture     :string(255)
#  description :text
#  price       :decimal(, )
#  stock       :integer
#  user_id     :integer
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

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
