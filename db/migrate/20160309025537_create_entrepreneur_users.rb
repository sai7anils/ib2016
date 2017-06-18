class CreateEntrepreneurUsers < ActiveRecord::Migration
  def change
    create_table :entrepreneur_users do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.datetime :dob
      t.integer :type
      t.integer :country
      t.integer :city
      t.boolean :gender
      t.integer :profession_type
      t.string :profession_company
      t.integer :profession_skill
      t.integer :profession_experience
      t.integer :graduation
      t.string :university
      t.string :mobile
      t.string :address
      t.string :website
      t.string :email_second
      t.text :about
      t.text :inspire_quote
      t.string :linkedin
      t.timestamps null: false
    end
  end
end
