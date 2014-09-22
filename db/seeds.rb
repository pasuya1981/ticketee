# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Project.delete_all
Ticket.delete_all
User.delete_all

admin = User.create(name: 'admin', password: 'admin', email: 'admin@admin.com', admin: true)
user = User.create(name: 'user', password: 'user', email: 'user@user.com')
guest = User.create(name: 'guest', password: 'guest', email: 'guest@guest.com')

5.times do |n|
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'qqqq')
end

10.times do |n|
  project = Project.create(name: Faker::Commerce.product_name)
  Permission.create(user: user, action: 'view', thing: project)
  5.times { |n| Ticket.create(project: project, 
  							  user: admin, 
  							  title: Faker::Commerce.product_name,
  							  description: Faker::Lorem.paragraph ) }
end


