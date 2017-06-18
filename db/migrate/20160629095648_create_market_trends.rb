class CreateMarketTrends < ActiveRecord::Migration
  def change
    create_table :market_trends do |t|
      t.integer :business_potential_id
      t.integer :market_growing
      t.text :startup_process
      t.integer :market_size
      t.text :describe
      t.string :approx

      t.timestamps null: false
    end
  end
end
