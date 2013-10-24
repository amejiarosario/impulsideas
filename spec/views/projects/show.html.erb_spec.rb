require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :title => "Title",
      :short_description => "Short Description",
      :extended_description => "MyText",
      :funding_goal => 1.5,
      :funding_duration => 1,
      :category => "Category",
      :tags => "Tags"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Short Description/)
    rendered.should match(/MyText/)
    rendered.should match(/1.5/)
    rendered.should match(/1/)
    rendered.should match(/Category/)
    rendered.should match(/Tags/)
  end
end
