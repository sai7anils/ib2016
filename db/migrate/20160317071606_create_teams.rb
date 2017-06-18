class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :designation
      t.date :joined_date
      t.string :email
      t.string :mobile
      t.string :linkedin
      t.string :skype

      t.timestamps null: false
    end
  end
end
