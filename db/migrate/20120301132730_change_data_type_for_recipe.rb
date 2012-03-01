class ChangeDataTypeForRecipe < ActiveRecord::Migration
  def up
    change_table :recipes do |t|
      t.change :difficulty, :integer
    end
  end

  def down
    change_table :recipes do |t|
      t.change :difficulty, :string
    end
  end
end
