class ChangeUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :home_town, :string
    change_column :users, :city, :string
  end
end
