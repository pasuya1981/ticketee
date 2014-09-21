require 'rails_helper'

feature "Profile page" do

  let!(:user) { FactoryGirl.create(:user) }

  before :each do
  	visit user_path(user)
  end
  
  scenario 'Viewing' do

  	expect(page).to have_content(user.name)
  	expect(page).to have_content(user.email)
  end

  scenario 'Editing user' do

  	click_link 'Edit profile'
  	fill_in 'Name', with: 'new_username'
  	click_button 'Update Profile'
  	expect(page).to have_content('Profile has been updated.')
  end

  scenario 'Editing user with invalid attributes' do

    click_link 'Edit profile'
    
  end
end