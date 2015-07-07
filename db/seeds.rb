require 'faker'

500.times do
  Vehicle.create!(
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

puts "Seed finished."
puts "#{Vehicle.count} vehicles created."