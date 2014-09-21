require 'rails_helper'

feature 'Hidden links' do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }

  context "Anonymous users" do

  	scenario "cannot see the New Project link" do
  	  visit '/'
  	  expect(page).to_not have_css('a', text: 'New Project')
  	end
  end

  context "Regular users" do

  	before do
  	  sign_in(user)
  	end

  	scenario 'Cannot see the New Project link' do
  	  visit '/'
  	  expect(page).to_not have_css('a', text: 'New Project')
      expect(feature_module_testor).to eq('test')
  	end
  end

  context 'Admin users' do

  	before do
  	  sign_in(admin)
  	end

  	scenario 'Can see the New Project link' do
  	  visit '/'
  	  expect(find_link('New Project').visible?).to be(true)
  	end
  end

  def sign_in(user)
  	visit '/'
  	click_link 'Sign in'
  	fill_in 'Name', with: user.name
  	fill_in 'Password', with: user.password
  	click_button 'Sign in'
  end
end