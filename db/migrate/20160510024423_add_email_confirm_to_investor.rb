class AddEmailConfirmToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :email_confirm, :text
    add_column :investors, :confirm_token, :string
  end
end
