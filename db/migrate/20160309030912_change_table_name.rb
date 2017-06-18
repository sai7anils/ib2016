class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :investor_users, :investors
    rename_table :entrepreneur_users, :entrepreneurs
    rename_table :startup_users, :startups
  end
end
