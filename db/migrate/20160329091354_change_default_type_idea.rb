class ChangeDefaultTypeIdea < ActiveRecord::Migration
  def change
    change_column :ideas, :idea_type, :boolean, default: true
  end
end
