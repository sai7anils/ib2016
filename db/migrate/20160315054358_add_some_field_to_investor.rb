class AddSomeFieldToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :first_name, :string
    add_column :investors, :last_name, :string
    add_column :investors, :gender, :boolean
    add_column :investors, :dob, :date
    add_column :investors, :website_secondary, :string
    add_column :investors, :skype, :string
  end
end
