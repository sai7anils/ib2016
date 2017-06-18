class CreateStartUpId < ActiveRecord::Migration
  def change
    add_column :teams, :startup_id, :integer
  end
end
