class CreateFoodItems < ActiveRecord::Migration
  def change
    create_table :food_items do |t|
      t.string :name
      t.decimal :price
      t.boolean :certified

      t.timestamps
    end
  end
end
