class CreateFoodItems < ActiveRecord::Migration
  def change
    create_table :food_items do |t|
      t.string :name
      t.decimal :price
      t.boolean :certified, :default => false

      t.timestamps
    end
  end
end
