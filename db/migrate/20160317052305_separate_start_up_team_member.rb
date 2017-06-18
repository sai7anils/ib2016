class SeparateStartUpTeamMember < ActiveRecord::Migration
  def change
    remove_column :startups, :team_name
    remove_column :startups, :team_designation
    remove_column :startups, :team_joined_date
    remove_column :startups, :team_email_d
    remove_column :startups, :team_mobile
    remove_column :startups, :team_linkedin
    remove_column :startups, :team_skype
  end
end
