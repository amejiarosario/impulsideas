require 'spec_helper'

describe "projects/index" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :title => "Title",
        :short_description => "Short Description",
        :extended_description => "MyText",
        :funding_goal => 1.5,
        :funding_duration => 1,
        :category => "Category",
        :tags => "Tags"
      ),
      stub_model(Project,
        :title => "Title",
        :short_description => "Short Description",
        :extended_description => "MyText",
        :funding_goal => 1.5,
        :funding_duration => 1,
        :category => "Category",
        :tags => "Tags"
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Short Description".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
  end
end
