# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.create!(:email=> 'admin@trip.com', :password => 'password')


# 10.times do 
#  	Crm.create!(:user_id => 1, :package_id => 1, :name=> Faker::Name.name, :destination=> Faker::Address.city, :start_from => Faker::Address.city, :visit_date=> Faker::Date.between(2.days.ago, Date.today), :assigned_to=> Faker::Internet.email, :visit_for=> Faker::Lorem.word , :is_customize_request=> true, :status=> Faker::Lorem.word)
#  end

# Active admin

 AdminUser.create(:email=> 'admin@example.com', :password=> "password", :password_confirmation=> "password", :role=> 'admin')
