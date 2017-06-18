class RemoveForeignKeyUserIdOnEntrepreneurInvestorStartup < ActiveRecord::Migration
  def change
    remove_foreign_key :entrepreneurs, :users
    remove_foreign_key :investors, :users
    remove_foreign_key :startups, :users
  end
end
