# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  orderable_id   :integer
#  orderable_type :string(255)
#  payment_uid    :string(255)
#  amount         :decimal(8, 2)
#  description    :string(255)
#  raw            :hstore
#  completed      :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#

require 'spec_helper'

describe Order do
  pending "add some examples to (or delete) #{__FILE__}"
end
