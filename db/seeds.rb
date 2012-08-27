# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

###################
# Categoria
###################
Category.create(name: "Dessert")
Category.create(name: "Dish")
Category.create(name: "Soup")
Category.create(name: "Appetizer")
Category.create(name: "Beverage")
Category.create(name: "Sandwiche")
Category.create(name: "Breakfast & Brunch")

Effort.create(name: "easy") 
Effort.create(name: "medium") 
Effort.create(name: "hard") 

