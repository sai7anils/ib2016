class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :detail
      t.integer :receiver_id
      t.integer :sender_id

      t.timestamps null: false
    end
  end
end
