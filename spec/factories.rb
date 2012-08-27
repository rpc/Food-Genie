FactoryGirl.define do
  factory :category do
    name "dessert"  
  end

  factory :blender_form do
    title 'recipe blend'
    effort Random.rand(2)+1
    time Random.rand(100)
    category '2'
    many_ppl Random.rand(9)+1
    blending_text "mix it good all together"
    blending_ingredients "100g sugar\n 1kg strawberries"
  end

  factory :food_item do
    sequence(:name) { |n| "item#{n}" }
    price Random.rand(100)
    certified false
  end

  factory :recipe do
    sequence(:title) { |n| "MyRecipe#{n}" }
    effort_id Random.rand(2)+1
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