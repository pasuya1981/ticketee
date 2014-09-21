require 'rails_helper'

feature 'Singing up' do

  scenario 'Successful sign up' do

    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'user@hotmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content("You have signed up successfully.")
  end
end