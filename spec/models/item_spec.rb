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
# Indexes
#
#  index_items_on_project_id  (project_id)
#  index_items_on_user_id     (user_id)
#

require 'spec_helper'

describe Item do
  pending "add some examples to (or delete) #{__FILE__}"
end
