# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cooking_times = [10, 15, 25, 30, 45, 60, 75, 120]
measurements = ["cups", "tablespoons", "teaspoons", "liters", "milliliters", "ounces", "grams"]
faves = [true, false]

# 5.times do
#   Recipe.create(name: Faker::Food.dish, yield: rand(2..10), total_cooking_time: cooking_times.sample, directions: "Lorem Ipsum do the thing" )
# end
#
# 5.times do
#   User.create(username: Faker::Name.name)
# end
#
# 10.times do
#   Ingredient.create(name: Faker::Food.ingredient)
# end

i = 0
t = 0
5.times do
  user_id = User.all[i].id
  recipe_id = Recipe.all[i].id
  ingredient_id = Ingredient.all[t].id
  # PantryItem.create(ingredient_id: ingredient_id, user_id: user_id, quantity_in_stock: rand(1..10), unit_of_measurement: measurements.sample)
  recipe_ingredient = RecipeIngredient.new(ingredient_id: ingredient_id, recipe_id: recipe_id, quantity_used: rand(1..10), unit_of_measurement: measurements.sample)
  if recipe_ingredient.valid?
    recipe_ingredient.save
  else
    byebug
  end
  t += 1
  ingredient_id = Ingredient.all[t].id
  # PantryItem.create(ingredient_id: ingredient_id, user_id: user_id, quantity_in_stock: rand(1..10), unit_of_measurement: measurements.sample)
  recipe_ingredient = RecipeIngredient.new(ingredient_id: ingredient_id, recipe_id: recipe_id, quantity_used: rand(1..10), unit_of_measurement: measurements.sample)
  if recipe_ingredient.valid?
    recipe_ingredient.save
  else
    byebug
  end

  recipe_card = RecipeCard.new(recipe_id: recipe_id, user_id: user_id, rating: rand(1..5))
  if recipe_card.rating > 3
    recipe_card.favorite = true
  else
    recipe_card.favorite = false
  end
  if recipe_card.valid?
    recipe_card.save
  else
    byebug
  end
  i += 1
  t += 1
end
