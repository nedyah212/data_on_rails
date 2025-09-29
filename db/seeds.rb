require 'faker'
require 'csv'



##Seed manufacturers 1/8
puts "Seeding Manufacturers..."
csv_text = File.read(Rails.root.join('db', '/seeds/manufacturers.csv'))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Manufacturer.create!(
    id: row['make_id'].to_i,
    make: row['make']
  )
end
puts "Created #{Manufacturer.count} manufacturers"



### Seed Features 2/8
Feature.destroy_all
puts "Seeding Car Features with Faker..."
categories = ["Safety", "Entertainment", "Comfort", "Technology", "Exterior", "Performance", "Interior"]
50.times do |i|
  Feature.create!(
    name: "#{Faker::Vehicle.manufacture} #{Faker::Commerce.product_name} System #{i}",
    category: categories.sample,
    base_cost: [rand(100..3000)].sample
  )
end
puts "Created #{Feature.count} car features"



### Seed Cities 3/8
City.destroy_all