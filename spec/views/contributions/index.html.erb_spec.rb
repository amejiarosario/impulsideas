require 'spec_helper'

describe "contributions/index" do
  before(:each) do
    assign(:contributions, [
      stub_model(Contribution,
        :amount => 1.5
      ),
      stub_model(Contribution,
        :amount => 1.5
      )
    ])
  end

  it "renders a list of contributions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
