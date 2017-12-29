# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# Serious Eats Seed Test

breakfast = [
    "http://www.seriouseats.com/recipes/2017/12/bravetart-homemade-cinnamon-rolls-recipe.html",
    "http://www.seriouseats.com/recipes/2017/07/classic-over-easy-fried-eggs-recipe.html",
    "http://www.seriouseats.com/recipes/2017/07/classic-sunny-side-up-eggs-recipe.html",
    "http://www.seriouseats.com/recipes/2017/07/perfect-soft-boiled-eggs.html",
    "http://www.seriouseats.com/recipes/2017/06/crispy-homemade-granola-recipe.html",
    "http://www.seriouseats.com/recipes/2017/06/chorizo-egg-salsa-verde-chilaquiles-recipe.html",
    "http://www.seriouseats.com/recipes/2017/05/french-toast-quick-blackberry-compote-recipe.html",
    "http://www.seriouseats.com/recipes/2017/05/savory-buckwheat-crepes-galettes-bretonnes-recipe.html",
    "http://www.seriouseats.com/recipes/2017/05/easy-coffee-cake-recipe.html",
    "http://www.seriouseats.com/recipes/2017/04/ham-and-cheese-scones-recipe.html",
    "http://www.seriouseats.com/recipes/2017/03/basic-crepes-batter-recipe.html"
]


# unit_of_measurement = ["ounce","cup","gram","tablespoon","teaspoon"]
def deduplicate_commas(string)
  if string.include?(",,")
    string.gsub!(",,",",")
  end

  if stirng.include?(" , ")
    string.gsub!(" , ", ", ")
  end
end

def fraction_to_float(string)
  numerator, denominator = string.split('/').map(&:to_f)
  denominator ||= 1
  numerator/denominator
end

def full_string_to_float(string)
  if string.include?("/") && string.include?(" ")
    full_string = string.split(" ")
    full_string.first.to_f + fraction_to_float(full_string.last)
  elsif string.include?("/")
    fraction_to_float(string)
  else
    string.to_f
  end
end


def depluralize_unit_of_measurement(string)
  if string[-1] == "s"
    string[-1] = ""
  end
    string
end



def ingredient_snippet_to_ingredient_name_and_instruction(ingredient_snippet) # returns array. first element is the name of ingredient, second element is instructions for recipe_ingredient

  if ingredient_snippet.match(/\([^)]+\)/)
    ingredient_snippet.gsub!(/\([^)]+\)/,"")
  end
  if ingredient_snippet.include?("high-quality")
    ingredient_snippet.gsub!("high-quality","")
  end
  result = []
  if ingredient_snippet.include?("plain, ")
    partitioned_snippet = ingredient_snippet.partition(",").last.strip.partition(/(; )|(, )/)
    result[0] = "plain, " + partitioned_snippet[0].strip
    result[1] = partitioned_snippet[2].strip
  else
    partitioned_snippet = ingredient_snippet.partition(/(; )|(, )/)
    result[0] = partitioned_snippet.first.strip
    result[1] = partitioned_snippet[2].strip
  end
  if result[1] != ""
    result[1] = ", " + result[1]
  end
  result.map {|string| deduplicate_commas(string)}
# split on first comma or semi-colon, but ignore if comma is after "plain" (if applicable)
end

def deduplicate_commas(string)
  if string.include?(",,")
    string.gsub!(",,",",")
  end

  if string.include?(" , ")
    string.gsub!(" , ", ", ")
  end
  string
end

def remove_adjectives(htmlingredient)
  adjectives = ["shredded","minced", "chopped","diced","fully","cooked","grated","coarsely","coarse","shredded,","minced,", "chopped,","diced,","cooked,","grated,","coarsely,","coarse,","melted","melted,","cold","cold,"]
  htmlingredient.split(" ").reject {|word| adjectives.include?(word)}.join(" ")
end

def rearrange_htmlingredient_with_from(htmlingredient)
  result = []
  partitioned_ingredient = htmlingredient.partition("from")
  instructions = partitioned_ingredient[0]

  result = partitioned_ingredient[2].partition(/(; )|(, )/)
  result[0] = result[0].strip
  result[1] += "using " + instructions + ", "
  result[2] = result[2].strip
  deduplicate_commas(result.join)
end


def htmlingredient_to_recipe_ingredient_record(htmlingredient, recipe_id)
# can handle:
  recipe_ingredient = RecipeIngredient.new
  htmlingredient = remove_adjectives(htmlingredient)
  if htmlingredient.match(/([0-9]+ to [0-9]+)/)
    htmlingredient = htmlingredient.partition(" to ").last
  end

  if htmlingredient.include?("plain or ")
    htmlingredient = htmlingredient.gsub("plain or ", "")
  end

  if htmlingredient.include?(" or ")
    htmlingredient = htmlingredient.gsub(" or ", ", or ")
  end
  htmlingredient = deduplicate_commas(htmlingredient)
  if !htmlingredient.match(/[0123456789]/)
    return
  elsif htmlingredient.include?("from")
    ingredient = rearrange_htmlingredient_with_from(htmlingredient)
    recipe_ingredient.unit_of_measurement = "unit"
    full_text = ingredient.partition(/\D/)
    recipe_ingredient.quantity_used = full_text[0]
  elsif htmlingredient.match(/(quart)|(slices)|(ounce)|(cup)|(gram)|(tablespoon)|(teaspoon)|(pound)|([0-9]+ml)|([0-9]+g)/)
    full_text = htmlingredient.partition(/(quarts)|(quart)|(slices)|(g)|(ml)|(ounces)|(cups)|(grams)|(tablespoons)|(teaspoons)|(pounds)|(pound)|(ounce)|(cup)|(gram)|(tablespoon)|(teaspoon)/)

    recipe_ingredient.quantity_used = full_string_to_float(full_text[0])
    recipe_ingredient.unit_of_measurement = depluralize_unit_of_measurement(full_text[1])

  else
    # if it does not contain a unit of measurement, but does contain a number
    recipe_ingredient.unit_of_measurement = "unit"
    full_text = htmlingredient.partition(/\D/)
    recipe_ingredient.quantity_used = full_text[0]


  end

  ingredient_with_instruction = ingredient_snippet_to_ingredient_name_and_instruction(full_text[2].strip)
  recipe_ingredient.extra_instructions = deduplicate_commas(ingredient_with_instruction[1]).strip
  ingredient = Ingredient.find_or_create_by(name: ingredient_with_instruction[0].strip)
  recipe_ingredient.ingredient_id = ingredient.id
  recipe_ingredient.recipe_id = recipe_id
  if recipe_ingredient.valid?
    recipe_ingredient.save
  else
    byebug
  end
  recipe_ingredient
end

breakfast.each do |url|
  hash = Nokogiri::HTML(RestClient.get("#{url}"))
  recipe = Recipe.find_or_initialize_by(name: hash.title.split(" | Serious Eats").first)
  recipe.yield = hash.css("ul.recipe-about span.info.yield").text
  recipe_info = hash.css("ul.recipe-about span")
  total_time = recipe_info.select.with_index do |element, index|
    element.child.text.include?("Total time:") || recipe_info[index-1].child.text.include?("Total time:")
  end
 
  recipe.total_cooking_time = total_time.last.child.text

  # recipe_info.each_with_index do |element, index|
  #   if element.child.text.include?("Total Time")
  #     recipe.total_cooking_time = recipe_info[i+1].child.text
  #   end
  # end

  if recipe.valid?
    recipe.save
  else
    byebug
  end

  hash.css("li.recipe-procedure").each do |htmlstep|
    instruction = Instruction.new
    instruction.instruction_number = htmlstep.css("div.recipe-procedure-number").text.split(".").first
    instruction.instruction_text = htmlstep.css("div.recipe-procedure-text").text.split("\n")[1].split("                        ").last
    instruction.recipe_id = recipe.id
    if instruction.valid?
      instruction.save
    else
      byebug
    end
  end

  hash.css("div.recipe-ingredients li.ingredient").each do |htmlingredient|
    htmlingredient_to_recipe_ingredient_record(htmlingredient.text, recipe.id)
  end
end
