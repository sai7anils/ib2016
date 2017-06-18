class CreateFundings < ActiveRecord::Migration
  def change
    create_table :fundings do |t|
      t.integer :funding_type
      t.integer :amount
      t.date :date
      t.string :by_investor
      t.integer :startup_id
      t.timestamps null: false
    end
  end
end
