class AddMarketTrendToMarketAnalysis < ActiveRecord::Migration
  def change
    add_column :market_analyses, :market_trend, :integer
  end
end
