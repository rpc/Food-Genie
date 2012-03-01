Factory.define :category do |c|
  c.name "dessert"  
end

Factory.define :recipe do |r|
  r.sequence(:title) { |n| "MyRecipe#{n}" }
  r.difficulty '3'
  r.time '25'
  r.association :category
  r.sequence(:text) { |n| "Mix it all together for recipe #{n}" }
end


