class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :file
      t.integer :pitch_bull_id

      t.timestamps null: false
    end
  end
end
