require 'spec_helper'

feature "Creating new projects" do
  scenario "it succeed with all the required fields are provided" do
    visit new_project_path
    fill_in 'Title', with: 'My Project'
    # fill_in :media, with: 'Photo or Video'
    fill_in 'Short description', with: 'This is my project and support me'
    fill_in 'Extended description', with: 'Bla bla bla'
    fill_in 'Funding goal', with: 930
    fill_in 'Funding duration', with: 60
    fill_in 'Tags', with: 'test, capybara'
    click_button 'Create Project'
    # save_and_open_page
    expect(page).to have_content 'Success'
  end

  scenario "created projects are displayed in the home page"
  scenario "created projects can be shared on facebook"
end

feature "Backers" do
  scenario "Backers can make donations to a project"
  scenario "Backers can cancel donations"
end