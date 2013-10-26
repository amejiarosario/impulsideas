require 'spec_helper'

feature "Projects" do
  given(:user) { FactoryGirl.create :user }

  scenario 'anonymous users cannot create projects' do
    visit new_project_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario "it succeed creating project when all the required fields are provided" do
    login_as user, scope: :user
    visit new_project_path
    fill_in 'Title', with: 'My Project'
    # fill_in :media, with: 'Photo or Video'
    fill_in 'Short description', with: 'This is my project and support me'
    fill_in 'Extended description', with: 'Bla bla bla'
    fill_in 'Funding goal', with: 930
    fill_in 'Funding duration', with: 60
    fill_in 'Tags', with: 'test, capybara'
    click_button 'Create Project'
    expect(page).to have_content /success/i
  end

  scenario "created projects are displayed in the home page" do
    FactoryGirl.create :project,
      title: 'The awesome',
      short_description: 'Back us, this project is awesome'
    visit root_path
    expect(page).to have_content 'The awesome'
    expect(page).to have_content 'Back us, this project is awesome'
  end

  scenario 'creator can modify the project' do
    creator = FactoryGirl.create :user
    project = FactoryGirl.create :project, user: creator
    login_as creator, scope: :user
    visit edit_project_path(project)
    fill_in 'Short description', with: 'support us!'
    click_button 'Update Project'
    expect(page).to have_content 'support us!'
  end

  scenario 'a user cannot modify a project is not his' do
    creator = FactoryGirl.create :user
    project = FactoryGirl.create :project, user: creator
    login_as user, scope: :user
    visit edit_project_path(project)
    # save_and_open_page
    expect(page).to have_content 'You cannot modify this project'
  end

  scenario 'a user cannot delete a project is not his'
  scenario "created projects can be shared on facebook"
end

feature "Backers" do
  scenario "Backers can make donations to a project"
  scenario "Backers can cancel donations"
end