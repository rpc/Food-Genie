class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :many_ppl
      t.string :title
      t.string :difficulty
      t.integer :time
      t.integer :category_id
      t.string :text
      t.boolean :approved
      t.binary :extra_content

      t.timestamps
    end
  end
end
