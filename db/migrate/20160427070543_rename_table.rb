class RenameTable < ActiveRecord::Migration
  def change
    rename_table :team_cappabilitities, :team_cappabilities
  end
end
