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

class User < ActiveRecord::Base

  has_secure_password
  has_many :tickets

  def to_s
  	"#{email} (#{admin ? 'Admin' : 'User'})"
  end
end
