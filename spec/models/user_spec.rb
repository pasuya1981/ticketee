require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:valid_attributes) {
    {name: 'Peter', password: '123456789', password_confirmation: '123456789'}
  }

  let(:invalid_attributes) {
    {name: 'John', password: '987654', password_confirmation: '34716234'}
  }

  describe "Password" do

  	it "need a password and confirmation to save" do

  	  u = User.new(name: 'steve')

  	  u.save
  	  expect(u).to_not be_valid

  	  u.password = 'password'
  	  u.password_confirmation = 'invalid confirm'

  	  u.save
  	  expect(u).to_not be_valid

  	  u.password_confirmation = 'password'
  	  u.save
  	  expect(u).to be_valid
   	end

   	it "needs password and confirmation to match" do
   	  u = User.create(invalid_attributes)
   	  u.save
   	  expect(u).to_not be_valid
   	end
  end

  describe "authentication" do
  	let(:user) { User.create(valid_attributes) }

  	it "authenticate with correct password" do
  	  expect(user.authenticate(valid_attributes[:password])).to be
  	end

  	it "incorrect password" do
  	  expect(user.authenticate('not correct')).to_not be
  	end
  end
end