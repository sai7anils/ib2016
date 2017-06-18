class CreateCompetitorTeam < ActiveRecord::Migration
  def change
    create_table :competitor_teams do |t|
      t.integer :competitor_id
      t.string :name
      t.string :business_line
      t.string :country
      t.string :revenue
      t.string :website
      t.timestamps null: false
    end
  end
end
