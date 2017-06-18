class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :idea_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
