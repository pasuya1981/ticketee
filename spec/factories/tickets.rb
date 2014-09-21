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
#

FactoryGirl.define do
  factory :ticket do
    title 'Example Ticket'
    description 'An example ticket, nothing more'
  end
end
