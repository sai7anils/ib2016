class AddPortfolioWebsiteFieldToInvester < ActiveRecord::Migration
  def change
    add_column :investors, :portfolio_website, :string
  end
end
