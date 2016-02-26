# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

user = User.create(email: "nhamtybv@gmail.com", password: "123456789", password_confirmation: "123456789")

10.times { Product.create(title: FFaker::Product.product_name, price: rand()*1000, user_id: user) }
