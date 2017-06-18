class CreateInvestorTeam < ActiveRecord::Migration
  def change
    create_table :investor_teams do |t|
      t.string :name
      t.integer :designation
      t.date :joined_date
      t.string :email
      t.string :mobile
      t.string :linkedin
      t.string :skype
      t.integer :investor_id
      t.timestamps null: false
    end
  end
end
