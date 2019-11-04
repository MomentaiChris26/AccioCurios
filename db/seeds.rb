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
end

# Create new user accounts
def user_accounts
  5.times do
    user = User.new
    user.username = Faker::Internet.user_name
    user.email = Faker::Internet.email
    user.password = "123456789"
    user.password_confirmation = "123456789"
    user.save!
  end
end

# Creates template for product conditions to be used
def seed_conditions
  template_conditions = ["New","Used","Old"]
  template_conditions.each do |condition|
    Condition.create(status: condition)
  end
end

# Creates template categories for testing purposes
def seed_categories
  template_categories = ["Toys","Cards","Video Games","Misc"]
  template_categories.each do |category|
    Category.create(name: category)
  end
end




# Runs methods above 
admin_account
user_accounts
seed_conditions
seed_categories