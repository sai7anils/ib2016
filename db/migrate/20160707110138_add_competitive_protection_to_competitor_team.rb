class AddCompetitiveProtectionToCompetitorTeam < ActiveRecord::Migration
  def change
    add_column :competitor_teams, :competitive_protection_id, :integer
  end
end
