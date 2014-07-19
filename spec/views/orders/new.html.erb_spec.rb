require 'spec_helper'

describe "orders/new" do
  before(:each) do
    assign(:order, stub_model(Order,
      :user => nil,
      :payment_id => "MyString",
      :amount => "9.99",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", orders_path, "post" do
      assert_select "input#order_user[name=?]", "order[user]"
      assert_select "input#order_payment_id[name=?]", "order[payment_id]"
      assert_select "input#order_amount[name=?]", "order[amount]"
      assert_select "input#order_description[name=?]", "order[description]"
    end
  end
end
