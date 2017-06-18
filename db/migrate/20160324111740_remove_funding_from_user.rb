class RemoveFundingFromUser < ActiveRecord::Migration
  def change
    remove_column :startups, :funding_type
    remove_column :startups, :funding_amout
    remove_column :startups, :funding_date
    remove_column :startups, :funding_by_investor
  end
end
