class RemoveSomeFieldFromSomeTable < ActiveRecord::Migration
  def change
    remove_column :investors, :country
    remove_column :investors, :city
    remove_column :entrepreneurs, :country
    remove_column :entrepreneurs, :city
    remove_column :startups, :country
    remove_column :startups, :city
  end
end
