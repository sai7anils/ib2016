class CreateExitStrategy < ActiveRecord::Migration
  def change
    create_table :exit_strategies do |t|
      t.integer :business_idea_id
      t.text :business_exit_strategy
      t.timestamps null: false
    end
  end
end
