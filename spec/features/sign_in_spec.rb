require 'rails_helper'

feature 'Signing in' do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'Sign ing in via form' do

  	visit '/'
  	click_link 'Sign in'
  	fill_in 'Name', with: user.name
  	fill_in 'Password', with: user.password
  	click_button 'Sign in'

  	expect(page).to have_content('Signed in successfully.')
  end
end