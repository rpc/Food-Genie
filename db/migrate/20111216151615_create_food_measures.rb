class CreateFoodMeasures < ActiveRecord::Migration
  def change
    create_table :food_measures do |t|
      t.integer :food_item_id
      t.integer :quantity

      t.timestamps
    end
  end
end
