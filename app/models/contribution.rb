class Contribution < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :payment_notifications, dependent: :destroy

  validates :amount, numericality: { greater_than: 0 }, presence: true
  validates :user_id, presence: true
end
