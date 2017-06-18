class AddSomeFieldToInvester < ActiveRecord::Migration
  def change
    add_column :investors, :description, :text
    add_column :investors, :team_name, :string
    add_column :investors, :team_designation, :integer
    add_column :investors, :team_joined_date, :date
    add_column :investors, :team_email_id, :string
    add_column :investors, :team_mobile, :string
    add_column :investors, :team_linkedin, :string
    add_column :investors, :team_skype, :string
    add_column :investors, :address_line_1, :string
    add_column :investors, :address_line_2, :string
    add_column :investors, :startup_name, :string
    add_column :investors, :startup_logo, :string
    add_column :investors, :funding_round, :string
    add_column :investors, :funding_amount, :string
    add_column :investors, :facebook, :string
    add_column :investors, :twitter, :string
    add_column :investors, :linkedin, :string
    add_column :investors, :ios_app, :string
    add_column :investors, :adroid_app, :string
    add_column :investors, :windows_app, :string
    add_column :investors, :business_line, :string
  end
end
