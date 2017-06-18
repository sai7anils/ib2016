class AddBusinessIdeaTypeToBusinessIdeaTable < ActiveRecord::Migration
  def change
    add_column :business_ideas, :business_idea_type, :integer
  end
end
