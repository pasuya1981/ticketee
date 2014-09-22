# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base

  validates_presence_of :name
  has_many :tickets, dependent: :destroy
  has_many :permissions, as: :thing

  scope :viewable_by, ->(user) { joins(:permissions).where(permissions: { action: 'view', user_id: user.id }) }
end
