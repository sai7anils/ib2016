class CreateLikeComment < ActiveRecord::Migration
  def change
    create_table :like_comments do |t|
      t.integer :user_id
      t.integer :comment_id
      t.timestamps null: false
    end
  end
end
