require 'rails_helper'

feature "Deleting Users" do
  
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as! admin
    click_link 'Admin'
    click_link 'Users'
 	click_link user.email
 	click_link 'Delete user'
  end

  after do
    User.delete_all
    Project.delete_all
  end

  scenario 'Delete a user' do
    expect(page).to have_content('User has been destroyed.')
  end

  scenario 'Users cannot delete themselves' do
  	click_link admin.email
  	click_link 'Delete user'
  	expect(page).to have_content("You cannot delete yourself.")
  end
end