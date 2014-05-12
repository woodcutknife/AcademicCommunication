# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: 'User')
Role.create(name: 'Judge')
Role.create(name: 'ContestAdmin')
Role.create(name: 'SuperAdmin')

super_admin = Account.create(email: 'admin@example.com', password: 'password')
super_admin.roles << Role.where(name: 'SuperAdmin').first
super_admin.save
