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

class Item < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :project
  has_many :orders, as: :orderable

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :user_id, presence: true

  def to_param
    "#{id} #{title}".parameterize
  end

  def sold_out?
    self.stock <= 0
  end
end
