class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.string :query
      t.integer :time
      t.string :difficulty
      t.string :category
      t.integer :many_ppl
      t.string :action 
      t.string :who

      t.timestamps
    end
  end
end
