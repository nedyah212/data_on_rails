require 'faker'
require 'csv'

##Seed manufacturers 1/8
Manufacturer.destroy_all
puts "Seeding Manufacturers from file"
csv_text = File.read(Rails.root.join('db', 'seeds/manufacturers.csv'))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Manufacturer.create!(
    name: row['name'],
    country: row['country'],
    founded_year: row['founded_year']
  )
end
puts "Created #{Manufacturer.count} manufacturers"

### Seed Features 2/8
Feature.destroy_all
puts "Seeding Car Features with Faker..."
categories = ["Safety", "Entertainment", "Comfort", "Technology", "Exterior", "Performance", "Interior"]
50.times do |i|
  Feature.create!(
    name: "#{Faker::Commerce.product_name}",
    description: "#{Faker::Marketing.buzzwords}",
    category: categories.sample,
    base_cost: rand(100..3000)
  )
end
puts "Created #{Feature.count} car features"

### Seed Cities 3/8
City.destroy_all
puts 'Seeding Cities from file'
csv_text = File.read(Rails.root.join('db', 'seeds/cities.csv'))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  City.create!(
    name: row['name'],
    province: row['province'],
    country: row['country'],
    population: row['population'].to_i
  )
end
puts "Created #{City.count} cities"

### Seed Dealerships 4/8
Dealership.destroy_all
puts "Seeding Dealerships with Cities and Faker...."
27.times do |i|
  Dealership.create!(
    name: "#{Faker::Company.name} #{['Motors', 'Autos', 'Cars', 'Dealership', 'Garage'].sample}",
    address: "#{Faker::Address.street_address}, #{Faker::Address.zip}",
    phone: Faker::Base.numerify('+1-###-###-####'),
    city: City.all.sample
  )
end
puts "Created #{Dealership.count} dealerships"

### Seed Cars 5/8
Car.destroy_all
puts "Seeding Cars with Manufacturers, and API
