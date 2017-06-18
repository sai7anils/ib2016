class CreateNotification < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :message
      t.integer :user_id
      t.integer :idea_id
      t.integer :notification_type
      t.timestamps null: false
    end
  end
end
