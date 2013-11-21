class Contribution < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :payment_notifications
end
