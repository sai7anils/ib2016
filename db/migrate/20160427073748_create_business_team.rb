class CreateBusinessTeam < ActiveRecord::Migration
  def change
    create_table :business_teams do |t|
      t.integer :team_cappabilitie_id
      t.string :name
      t.string :role
      t.string :skills
      t.string :joined
      t.string :profile_image
      t.timestamps null: false
    end
  end
end
