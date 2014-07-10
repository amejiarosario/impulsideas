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
end
