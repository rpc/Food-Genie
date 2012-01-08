class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :food_item_id
      t.string :quantity
      t.string :measure
      t.integer :recipe_id
      t.timestamps
    end
  end
end
