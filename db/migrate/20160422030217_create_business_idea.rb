class CreateBusinessIdea < ActiveRecord::Migration
  def change
    create_table :business_ideas do |t|
      t.integer :idea_id
      t.integer :business_line
      t.string :tagline
      t.text :problem_statement
      t.text :solution
      t.string :idea_stage
      t.string :ip_patent
      t.integer :motivation_vision
      t.integer :year_exp
      t.integer :startup_business
      t.integer :business_model
      t.text :des_business_model
      t.text :idea_execution
      t.timestamps null: false
    end
  end
end
