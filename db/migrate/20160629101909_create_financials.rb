class CreateFinancials < ActiveRecord::Migration
  def change
    create_table :financials do |t|
      t.integer :fund_startup_id
      t.integer :revenue
      t.integer :often
      t.integer :previous_revenue
      t.integer :current_revenue
      t.integer :previous_netprofit
      t.boolean :crowd_funding
      t.boolean :put_money
      t.string :balance_sheet
      t.string :cash_flow
      t.text :equity_debt

      t.timestamps null: false
    end
  end
end
