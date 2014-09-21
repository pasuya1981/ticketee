require 'rails_helper'

feature "Deleting projects" do

  let(:admin_user) { FactoryGirl.create(:admin_user) }
  
  before do
    visit '/'
    click_link 'Sign in'
    fill_in 'Name', with: admin_user.name
    fill_in 'Password', with: admin_user.password
    click_button 'Sign in'
  end

  scenario "Should change projects count" do

  	FactoryGirl.create(:project, name: 'SublimeText 3')
    visit '/'
    click_link 'SublimeText 3'
    
    expect do
      click_link 'Delete Project'
    end.to change(Project, :count).by(-1)

    expect(page).to have_content('Project has been destroyed.')

  end
end