class CreateTeamCappabilititie < ActiveRecord::Migration
  def change
    create_table :team_cappabilitities do |t|
      t.integer :business_idea_id
      t.integer :crucial_skills
      t.integer :strength
      t.string :team_attributes
      t.timestamps null: false
    end
  end
end
