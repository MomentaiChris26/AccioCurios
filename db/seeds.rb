# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Creates new admin account
def admin_account
  User.create(username:"admin",email:"test@test.com",password: "admin12345",admin:true)
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
  template_categories = ["Toys","Cards","Video Games","Misc"]
  template_categories.each do |category|
    Category.create(name: category)
  end
  puts "created categories"
end

# def seed_listings
#   8.times do
#     listing = Listing.new
#     listing.title = Faker::App.name
#     listing.posted_date = Time.now()
#     listing.description = Faker::Quotes::Shakespeare.king_richard_iii_quote
#     listing.user_id = rand 1..5
#     listing.price = rand 1..500
#     listing.condition_id = rand 1..3
#     listing.category_id = rand 1..4
#     listing.save!
#   end
#   puts "Created listings"
# end


# Runs methods above 
admin_account
user_accounts
seed_conditions
seed_categories
# seed_listings