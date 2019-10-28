# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Creates an admin account for testing purposes
def seed_admin
  User.create(
    id: 1,
    username: "admin",
    email: "admin@test.com",
    password: '123456',
    password_confirmation: '123456',
    admin: true,
  )
end

# Creates a user account for testing purposes
def seed_test_user
  User.create(
    id: 2,
    username: "user",
    email: "test@test.com",
    password: '123456',
    password_confirmation: '123456',
    admin: false,
  )
end

# Creates template for product conditions to be used
def seed_conditions
  template_conditions = ["New","Used"]
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
seed_admin
seed_test_user
seed_conditions
seed_categories