# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Doce
r1fi1 = FoodItem.create(:name => "arroz")
r1fi2 = FoodItem.create(:name => "leite")
r1fi3 = FoodItem.create(:name => "canela")
r1fi4 = FoodItem.create(:name => "limao")
r1fi5 = FoodItem.create(:name => "agua")
r1fi6 = FoodItem.create(:name => "acucar")

# Meal
r2fi1 = FoodItem.create(:name => "margarina")
r2fi2 = FoodItem.create(:name => "carne")
r2fi3 = FoodItem.create(:name => "azeite")
r2fi4 = FoodItem.create(:name => "alho")
r2fi5 = FoodItem.create(:name => "cebola")
r2fi6 = FoodItem.create(:name => "feijao")

# Sopa
r3fi1 = FoodItem.create(:name => "tomate")
r3fi2 = FoodItem.create(:name => "batata")
r3fi3 = FoodItem.create(:name => "coentros")
r3fi4 = FoodItem.create(:name => "ovo")

###################
# Categoria
###################
cat1 = Category.create(:name => "Dessert")
cat2 = Category.create(:name => "Meal")
cat3 = Category.create(:name => "Soup")

###################
# Ingredientes
###################
Ingredient.create(:food_item_id => r1fi1.id, :quantity => 15, :recipe_id => 1)
Ingredient.create(:food_item_id => r1fi2.id, :quantity => 1, :recipe_id => 1)
Ingredient.create(:food_item_id => r1fi3.id, :quantity => 1, :recipe_id => 1)
Ingredient.create(:food_item_id => r1fi4.id, :quantity => 180, :recipe_id => 1)
Ingredient.create(:food_item_id => r1fi5.id, :quantity => 2, :recipe_id => 1)
Ingredient.create(:food_item_id => r1fi6.id, :quantity => 150, :recipe_id => 1)

Ingredient.create(:food_item_id => r2fi1.id, :quantity => 40, :recipe_id => 2)
Ingredient.create(:food_item_id => r2fi2.id, :quantity => 500, :recipe_id => 2)
Ingredient.create(:food_item_id => r2fi6.id, :quantity => 250, :recipe_id => 2)
Ingredient.create(:food_item_id => r1fi1.id, :quantity => 600, :recipe_id => 2)
Ingredient.create(:food_item_id => r2fi4.id, :quantity => 4, :recipe_id => 2)
Ingredient.create(:food_item_id => r2fi5.id, :quantity => 3, :recipe_id => 2)

Ingredient.create(:food_item_id => r3fi1.id, :quantity => 200, :recipe_id => 3)
Ingredient.create(:food_item_id => r3fi2.id, :quantity => 300, :recipe_id => 3)
Ingredient.create(:food_item_id => r3fi3.id, :quantity => 4, :recipe_id => 3)
Ingredient.create(:food_item_id => r3fi4.id, :quantity => 2, :recipe_id => 3)

##################
# Receitas
##################
Recipe.create(:many_ppl => 3, :title => "Sweet Rice", :difficulty => 'medium', :time => 20, :category_id => cat1.id, :text => "Mix it really gud")
Recipe.create(:many_ppl => 4, :title => "Chilli con Carne", :difficulty => 'hardcore', :time => 90, :category_id => cat2.id, :text => "Rub a a dub dub")
Recipe.create(:many_ppl => 6, :title => "Tomatto soup", :difficulty => 'easy', :time => 30, :category_id => cat3.id, :text => "Boil it!")


