class RenameRate < ActiveRecord::Migration
  def change
    rename_column :per_hours, :rate, :hour_rate
  end
end
