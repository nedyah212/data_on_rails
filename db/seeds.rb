require 'faker'
require 'csv'
require 'net/http'
require 'json'

##Seed manufacturers 1/9
Manufacturer.destroy_all
puts "\nSeeding Manufacturers from file"
csv_text = File.read(Rails.root.join('db', 'seeds/manufacturers.csv'))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Manufacturer.create!(
    name: row['name'],
    country: row['country'],
    founded_year: row['founded_year']
  )
end
puts "----Created #{Manufacturer.count} manufacturers"

##Seed Features 2/9
Feature.destroy_all
puts "Seeding Features from csv..."
csv_text = File.read(Rails.root.join('db', 'seeds/features.csv'))
csv = CSV.parse(csv_text, headers: true)

#Convert to array and shuffle
csv_rows = csv.to_a.shuffle

rand(25..53).times do
  manufacturer = Manufacturer.all.sample
  row = csv_rows.pop
  Feature.create!(
    name: row[1],
    description: row[3],
    category: row[2],
    base_cost: row[5].to_i,
    manufacturer_id: manufacturer.id
  )
end
puts "----Created #{Feature.count} features for #{Manufacturer.count} manufacturers"

### Seed Cities 3/9
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
puts "----Created #{City.count} cities"

### Seed Dealerships 4/9
Dealership.destroy_all
puts "Seeding Dealerships with Cities and Faker...."
4.times do |i|
  city = City.all.sample
  Dealership.create!(
    name: "#{Faker::Company.name} #{['Motors', 'Autos', 'Cars', 'Dealership', 'Garage'].sample}",
    address: "#{Faker::Address.street_address}, #{Faker::Address.zip}",
    phone: Faker::Base.numerify('+1-###-###-####'),
    city_id: city.id
  )
end
puts "----Created #{Dealership.count} dealerships"

### Seed Cars 5/9
### Dynamic seeding from carqueryapi.com
### I think this is a good enough reason to use a nested loop
### I want to avoid rate limiting, its a free api w/o a key
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
    rand(1..13).times do
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
    puts "----No data found for #{make.name} for year #{year}"
  end

end
puts "--Created #{Car.count} vehicles total"

##Seed car_features 6/9
CarFeature.destroy_all

puts "Seeding Car Features with Cars and Features"

#I know, nested loop......
Car.count.times do
  rand(0..4).times do
    car = Car.all.sample
    feature = Feature.all.sample
    unless CarFeature.exists?(car_id: car.id, feature_id: feature.id)
      CarFeature.create!(
        car_id: car.id,
        feature_id: feature.id,
        cost: feature.base_cost + rand(100..550),
        is_standard: [true, false].sample
      )
    end
  end
end
puts "----Created random #{CarFeature.count} car features"

##Seed People 7/9
Person.destroy_all
puts "Seeding People with Faker"

150.times do
  dealership = Dealership.all.sample
  Person.create!(
    city_id: dealership.city_id,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    age: rand(18..75),
    income_bracket: rand(30000..150000).to_s,
    phone: Faker::Base.numerify('+1-###-###-####')
  )
end
puts "----Created #{Person.count} people"

#Seed Salespeople 8/9
Salesperson.destroy_all
puts "Seeding Salespeople with Dealerships and People"

available_people = Person.pluck(:id).shuffle

Dealership.all.each do |dealership|
  rand(2..6).times do
    break if available_people.empty?

    person_id = available_people.pop

    Salesperson.create!(
      dealership_id: dealership.id,
      person_id: person_id,
      position: ['Sales Associate', 'Senior Sales Associate', 'Sales Manager', 'Junior Sales Associate'].sample
    )
  end
end
puts "----Created #{Salesperson.count} salespeople"

#Seed Car Purchases 9/9
CarPurchase.destroy_all
puts "Seeding Car Purchases with Cars, People, Dealerships"

available_cars = Car.pluck(:id).shuffle

percentage = rand(70..80) / 100.0
cars_to_sell = (available_cars.length * percentage).to_i

puts "Assigning purchases to #{cars_to_sell} out of #{available_cars.length} cars (#{(percentage * 100).to_i}%)"

available_cars.first(cars_to_sell).each do |car_id|
  dealership = Dealership.all.sample
  salesperson = Salesperson.where(dealership_id: dealership.id).sample

  next if salesperson.nil?

  begin
    CarPurchase.create!(
      car_id: car_id,
      person_id: Person.all.sample.id,
      dealership_id: dealership.id,
      salesperson_id: salesperson.id,
      purchase_date: Faker::Date.between(from: '2020-01-01', to: '2023-01-01'),
      price_paid: Faker::Commerce.price(range: 10000..100000),
      financing_type: ['cash', 'loan', 'lease'].sample,
      kilometers_at_purchase: rand(0..200000),
      condition: ['new', 'used', 'certified pre-owned'].sample
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create purchase for car #{car_id}: #{e.message}"
  end
end

puts "----Created #{CarPurchase.count} car purchases"