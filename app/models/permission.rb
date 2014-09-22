# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  thing_id   :integer
#  thing_type :string(255)
#  action     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Permission < ActiveRecord::Base
  
  belongs_to :user

  # // Polymorphic Association //
  # Permission.create!(user: user, action: action, thing: project_obj)
  # Rails auto save 2 fields
  # => thing_id = project_obj.id
  # => thing_type = project_obj.class.to_s
  belongs_to :thing, polymorphic: true
end
