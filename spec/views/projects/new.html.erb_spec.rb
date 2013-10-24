require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :title => "MyString",
      :short_description => "MyString",
      :extended_description => "MyText",
      :funding_goal => 1.5,
      :funding_duration => 1,
      :category => "MyString",
      :tags => "MyString"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "input#project_title[name=?]", "project[title]"
      assert_select "input#project_short_description[name=?]", "project[short_description]"
      assert_select "textarea#project_extended_description[name=?]", "project[extended_description]"
      assert_select "input#project_funding_goal[name=?]", "project[funding_goal]"
      assert_select "input#project_funding_duration[name=?]", "project[funding_duration]"
      assert_select "input#project_category[name=?]", "project[category]"
      assert_select "input#project_tags[name=?]", "project[tags]"
    end
  end
end
