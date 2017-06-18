class CreatePitchBurn < ActiveRecord::Migration
  def change
    create_table :pitch_burns do |t|
      t.integer :business_idea_id
      t.string :your_own
      t.string :your_video
      t.string :documents
      t.text :your_idea_legally
      t.timestamps null: false
    end
  end
end
