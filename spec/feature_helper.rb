

# For Capybara features test
module FeatureHelper

  def define_permission!(user, action, thing)
  	Permission.create!(user: user, action: action, thing: thing)
  end

  def sign_in_as!(user)
    visit '/'
    click_link 'Sign in'
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end

# For standard RSpec controller test.
module AuthHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end
end

# Configure RSpec to load module for Capybara-feature-test & RSpec-controller-test.
RSpec.configure do |config|

  config.include FeatureHelper, type: :feature
  config.include AuthHelpers, type: :controller
end