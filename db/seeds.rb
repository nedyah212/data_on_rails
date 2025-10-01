require 'faker'
require 'csv'
require 'net/http'
require 'json'

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
puts "Seeding Features with Faker..."
categories = ["Safety", "Entertainment", "Comfort", "Technology", "Exterior", "Performance", "Interior"]
50.times do |i|
  Feature.create!(
    ###This name is a placeholder until i update the feature table to link to the manufacturer
    name: "#{Faker::Vehicle.manufacture} #{Faker::Commerce.product_name}",
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
### I think this is a good enough reason to use a nested loop
### I want to avoid rate limiting, so I will make multiple calls to the API
Car.destroy_all
COLORS = ['Red', 'Blue', 'Green', 'Black', 'White', 'Silver', 'Yellow', 'Grey', 'Orange', 'Purple']
iterations = rand(5..15)

puts "Seeding Cars with Manufacturers, and API"
iterations.times do
  make = Manufacturer.all.sample
  year = rand(2015..2022)
  url = URI("http://www.carqueryapi.com/api/0.3/?cmd=getTrims&make=#{make.name}&year=#{year}")

  puts "Fetching data from API for #{make.name} for year #{year}"
  response = Net::HTTP.get(url)
  car_data = JSON.parse(response)
  sleep(0.25)

  if car_data['Trims'].any?
    rand(1..10).times do
      selection = car_data['Trims'].sample
      Car.create(
        manufacturer_id: make.id,
        model: selection['model_name'],
        year: selection['model_year'],
        color: COLORS.sample,
        trim: selection['model_trim'],
      )
    end
    puts "----Created #{Car.where(manufacturer_id: make.id, year: year).count} vehicles"
  else
    puts "No data found for #{make.name} for year #{year}"
  end

end
puts "Created #{Car.count} cars"
