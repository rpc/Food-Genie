class CreateFoodCategories < ActiveRecord::Migration
  def change
    create_table :food_categories do |t|
      t.string :meal_type

      t.timestamps
    end
  end
end
