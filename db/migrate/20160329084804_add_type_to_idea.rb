class AddTypeToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :idea_type, :boolean, default: false
  end
end
