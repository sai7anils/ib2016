class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :description
      t.string :attachment
      t.integer :views, default: 0

      t.timestamps null: false
    end
  end
end
