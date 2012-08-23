FactoryGirl.define do
  factory :category do
    name "dessert"  
  end

  factory :food_item do
    sequence(:name) { |n| "ingredient#{n}" }
    price '#{rand(100)}.#{rand(10)}'
    certified false
  end

  factory :recipe do
    sequence(:title) { |n| "MyRecipe#{n}" }
    effort_id '3'
    time '25'
    association :category
    sequence(:text) { |n| "Mix it all together for recipe #{n}" }
  end

  factory :ingredient  do
    association :food_item
    quantity '#{rand(10)}'
    measure 'g'
    association :recipe
  end
end