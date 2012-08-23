class RenameDifficultyToEffortId < ActiveRecord::Migration
  def up
  	rename_column :recipes, :difficulty, :effort_id
  end

  def down
  	rename_column :recipes, :effort_id, :difficulty
  end
end
