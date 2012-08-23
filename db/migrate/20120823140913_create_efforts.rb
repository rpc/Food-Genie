class CreateEfforts < ActiveRecord::Migration
  def change
    create_table :efforts do |t|
      t.string :name

      t.timestamps
    end
  end
end
