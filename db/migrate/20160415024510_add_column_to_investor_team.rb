class AddColumnToInvestorTeam < ActiveRecord::Migration
  def change
    add_column :investor_teams, :image, :string
  end
end
