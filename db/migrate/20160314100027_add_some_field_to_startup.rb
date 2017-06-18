class AddSomeFieldToStartup < ActiveRecord::Migration
  def change
    add_column :startups, :reg_company_name, :string
    add_column :startups, :facebook, :string
    add_column :startups, :twitter, :string
    add_column :startups, :linkedin, :string
    add_column :startups, :ios_app, :string
    add_column :startups, :adroid_app, :string
    add_column :startups, :window_app, :string
    add_column :startups, :address_line_1, :string
    add_column :startups, :address_line_2, :string
    add_column :startups, :team_name, :string
    add_column :startups, :team_designation, :integer
    add_column :startups, :team_joined_date, :date
    add_column :startups, :team_email_d, :string
    add_column :startups, :team_mobile, :string
    add_column :startups, :team_linkedin, :string
    add_column :startups, :team_skype, :string
    add_column :startups, :funding_type, :integer
    add_column :startups, :funding_amout, :string
    add_column :startups, :funding_date, :string
    add_column :startups, :funding_by_investor, :integer
  end
end
