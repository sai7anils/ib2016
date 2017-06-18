class ChangeSomeFieldUser < ActiveRecord::Migration
  def change
    rename_column :users, :home_town, :region
  end
end
