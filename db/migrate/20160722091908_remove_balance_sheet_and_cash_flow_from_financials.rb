class RemoveBalanceSheetAndCashFlowFromFinancials < ActiveRecord::Migration
  def change
    remove_column :financials, :balance_sheet, :string
    remove_column :financials, :cash_flow, :string
  end
end
