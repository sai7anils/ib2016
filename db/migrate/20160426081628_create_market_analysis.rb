class CreateMarketAnalysis < ActiveRecord::Migration
  def change
    create_table :market_analyses do |t|
      t.integer :business_idea_id
      t.boolean :is_new
      t.boolean :have_major
      t.integer :market_channels
      t.integer :market_size
      t.text :market_analyses_des
      t.timestamps null: false
    end
  end
end
