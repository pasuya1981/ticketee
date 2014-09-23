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

FactoryGirl.define do
  factory :ticket do
    title 'Test ticket title'
    description 'Test ticket description'
  end
end
