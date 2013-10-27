require 'spec_helper'

describe "contributions/edit" do
  before(:each) do
    @contribution = assign(:contribution, stub_model(Contribution,
      :amount => 1.5
    ))
  end

  it "renders the edit contribution form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contribution_path(@contribution), "post" do
      assert_select "input#contribution_amount[name=?]", "contribution[amount]"
    end
  end
end
