class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :idea_id
      t.text :message
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
