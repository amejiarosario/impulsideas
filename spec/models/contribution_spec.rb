require 'spec_helper'

describe Contribution do
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should have_many(:payment_notifications) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_presence_of(:user_id) }
end
