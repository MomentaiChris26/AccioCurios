# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Creates new admin account
def admin_account
  User.create(username:"admin",email:"admin@test.com",password: "admin12345",admin:true)
  puts "created admin account"
end

# Create new user accounts
def user_accounts
  
  3.times do
    user = User.new
    user.username = Faker::Internet.user_name
    user.email = Faker::Internet.email
    user.password = "123456789"
    user.password_confirmation = "123456789"
    user.save!
    puts "created user"
  end
end

# Creates template for product conditions to be used
def seed_conditions
  template_conditions = ["New","Used","Old"]
  template_conditions.each do |condition|
    Condition.create(status: condition)
  end
  puts "created conditions"
end

# Creates template categories for testing purposes
def seed_categories
  template_categories = ["Toys","Cards","Games","Misc"]
  template_categories.each do |category|
    Category.create(name: category)
  end
  puts "created categories"
end

# Runs methods above 
admin_account
user_accounts
seed_conditions
seed_categories

Listing.create(title:"Rare Charizard Card", posted_date: Time.now(),description: Faker::Lorem.sentence, user_id: rand(1..4),price: rand(1..500),condition_id: rand(1..3),category_id: 2 )
Listing.find(1).picture.attach(io: File.open('./app/assets/images/charizard.jpg'), filename: 'charizard.jpg')
puts "Created listings"
Listing.create(title:"Legend of Zelda NES",posted_date: Time.now(),description: Faker::Lorem.sentence, user_id: rand(1..4),price: rand(1..500),condition_id: 2,category_id: 3 )
Listing.find(2).picture.attach(io: File.open('./app/assets/images/zelda.jpg'), filename: 'zelda.jpg')
puts "Created listings"
Listing.create(title:"Lego Spaceman",posted_date: Time.now(),description: Faker::Lorem.sentence, user_id: rand(1..4),price: rand(1..500),condition_id: 2,category_id: 1 )
Listing.find(3).picture.attach(io: File.open('./app/assets/images/legospaceman.jpg'), filename: 'legospaceman.jpg')
puts "Created listings"
Listing.create(title:"Playstation 1",posted_date: Time.now(),description: Faker::Lorem.sentence, user_id: rand(1..4),price: rand(1..500),condition_id: 2,category_id: 4 )
Listing.find(4).picture.attach(io: File.open('./app/assets/images/ps1.jpg'), filename: 'ps1.jpg')
puts "Created listings"