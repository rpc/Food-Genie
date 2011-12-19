class AddRecipeIdToFoodMeasure < ActiveRecord::Migration
  def change
    add_column :food_measures, :recipe_id, :integer
  end
end
