require 'faker'

# Create Users
5.times do
    user = User.new(
       name: Faker::Name.name,
       username: Faker::Name.name,
       email: Faker::Internet.email,
       password: Faker::Lorem.characters(10) 
    )
    user.skip_confirmation!
    user.save!
end
users = User.all

# Create Vehicles
25.times do
  Vehicle.create!(
    user: users.sample,
    make: Faker::Company.name,
    model: Faker::Company.suffix,
    year: Faker::Number.number(4),
    production_date: Faker::Date.forward(23),
    engine: Faker::Lorem.words(4),
    transmission: Faker::Lorem.words(4),
    trim: Faker::Lorem.sentence,
    color: Faker::Lorem.word,
    options: Faker::Lorem.sentence,
    location: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
    )
end
vehicles = Vehicle.all

# Create a Regular User
user = User.first
user.skip_reconfirmation!
user.update_attributes!(
    email: 'member@example.com',
    password: 'helloworld'
)

# Create an Admin User
admin = User.new(
    name: 'Admin User',
    email: 'admin@example.com',
    password: 'helloworld',
    role: 'admin'
)
admin.skip_confirmation!
admin.save!

puts "Seed finished."
puts "#{User.count} users created."
puts "#{Vehicle.count} vehicles created."