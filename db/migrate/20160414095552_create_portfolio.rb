class CreatePortfolio < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.string :website
      t.integer :type
      t.string :amount
      t.string :logo
      t.integer :investor_id
      t.timestamps null: false
    end
  end
end
