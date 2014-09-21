# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  admin           :boolean          default(FALSE)
#

FactoryGirl.define do

  factory :user do

  	name "PeterMountain"
  	email 'user-wow@gmail.com'
  	password 'password_9999'
  	password_confirmation 'password_9999'

  	factory :admin_user do
  	  admin true
  	end
  end
end
