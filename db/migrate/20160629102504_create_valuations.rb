class CreateValuations < ActiveRecord::Migration
  def change
    create_table :valuations do |t|
      t.integer :fund_startup_id
      t.integer :currently_outstanding
      t.integer :total_fund
      t.integer :seeking
      t.integer :pre_money
      t.integer :business_stake
      t.text :use_fund

      t.timestamps null: false
    end
  end
end
