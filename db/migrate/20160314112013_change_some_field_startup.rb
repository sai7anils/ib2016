class ChangeSomeFieldStartup < ActiveRecord::Migration
  def change
    change_column :startups, :founded, :string
    change_column :startups, :strength, :string
    change_column :startups, :funding_by_investor, :string
  end
end
