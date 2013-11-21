require 'spec_helper'

describe "payment_notifications/show" do
  before(:each) do
    @payment_notification = assign(:payment_notification, stub_model(PaymentNotification,
      :params => "MyText",
      :status => "Status",
      :transaction_id => "Transaction",
      :contribution_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/Status/)
    rendered.should match(/Transaction/)
    rendered.should match(/1/)
  end
end
