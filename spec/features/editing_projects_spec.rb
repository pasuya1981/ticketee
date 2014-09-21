require 'rails_helper'

feature "Editing projects" do

  let(:admin_user) { FactoryGirl.create(:admin_user) }

  before do

    visit '/'
    click_link 'Sign in'
    fill_in 'Name', with: admin_user.name
    fill_in 'Password', with: admin_user.password
    click_button 'Sign in'

    FactoryGirl.create(:project, name: "TextMate 2")
  	visit '/'
  	click_link 'TextMate 2'
  	click_link 'Edit Project'
  end

  scenario "Updating a project with invalid attributes is bad" do
  	fill_in 'Name', with: ''
  	click_button 'Update Project'
  	expect(page).to have_content 'Project has not been updated.'
  end

  scenario "Updataing a project" do
  	
  	fill_in 'Name', with: 'TextMate 2 beta'
  	click_button 'Update Project'
  	expect(page).to have_content('Project has been updated.')
  end
end