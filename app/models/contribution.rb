class Contribution < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :payment_notifications

  validates :amount, numericality: { greater_than: 0 }, presence: true
end
