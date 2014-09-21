# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Ticket < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
