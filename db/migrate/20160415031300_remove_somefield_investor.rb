class RemoveSomefieldInvestor < ActiveRecord::Migration
  def up
    remove_column :investors, :team_name
    remove_column :investors, :team_designation
    remove_column :investors, :team_joined_date
    remove_column :investors, :team_email_id
    remove_column :investors, :team_mobile
    remove_column :investors, :team_linkedin
    remove_column :investors, :team_skype
    remove_column :investors, :startup_name
    remove_column :investors, :startup_logo
    remove_column :investors, :funding_round
    remove_column :investors, :funding_amount
    remove_column :investors, :portfolio_website
  end

  def down
    add_column :investors, :team_name
    add_column :investors, :team_designation
    add_column :investors, :team_joined_date
    add_column :investors, :team_email_id
    add_column :investors, :team_mobile
    add_column :investors, :team_linkedin
    add_column :investors, :team_skype
    add_column :investors, :startup_name
    add_column :investors, :startup_logo
    add_column :investors, :funding_round
    add_column :investors, :funding_amount
    add_column :investors, :portfolio_website
  end
end
