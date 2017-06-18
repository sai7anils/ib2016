class CreateFundPitchBurns < ActiveRecord::Migration
  def change
    create_table :fund_pitch_burns do |t|
      t.integer :fund_startup_id
      t.string :pitch
      t.string :video
      t.string :document
      t.integer :prefer_exit
      t.text :validation

      t.timestamps null: false
    end
  end
end
