# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



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
seed_conditions
seed_categories