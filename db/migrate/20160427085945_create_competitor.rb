class CreateCompetitor < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.integer :business_idea_id
      t.string :image
      t.text :about
      t.timestamps null: false
    end
  end
end
