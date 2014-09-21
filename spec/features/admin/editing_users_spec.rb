require 'rails_helper'

feature 'Editing users' do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin_user) { User.create(name: 'admin', 
  								  email: 'admin@example.com', 
  								  password: 'admin', 
  								  password_confirmation: 'admin', 
  								  admin: true) }

  before do
 	sign_in_as! admin_user
 	click_link 'Admin'
 	click_link 'Users'
 	click_link user.email
 	click_link 'Edit User'
  end

  scenario 'Updating the user details' do

  	fill_in 'Email', with: 'newguy@example.com'
  	click_button 'Update User'

  	expect(page).to have_content('User has been updated.')
  	within('#users') do
  	  expect(page).to have_content('newguy@example.com')
  	  expect(page).to have_content(user.reload.email)
  	end
  end

  scenario "Toggling user's admin ability" do
    check "Is an admin?"
    click_button 'Update User'

    expect(page).to have_content("User has been updated.")

    within('#users') do
      expect(page).to have_content("#{user.email} (Admin)")
    end
  end
end