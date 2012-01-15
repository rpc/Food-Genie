class CreateBlenders < ActiveRecord::Migration
  def change
    create_table :blenders do |t|
      t.string :difficulty
      t.integer :time
      t.integer :category
      t.integer :many_ppl
      t.string :title
      t.string :blending_ingredients
      t.string :blending_text

      t.timestamps
    end
  end
end
