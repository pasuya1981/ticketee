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

20.times do |n|
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'qqqq')
end

50.times do |n|
  Project.create(name: Faker::Commerce.product_name)
end

User.create(name: 'admin', password: 'admin', email: 'admin@admin.com', admin: true)
User.create(name: 'user', password: 'user', email: 'user@user.com')
