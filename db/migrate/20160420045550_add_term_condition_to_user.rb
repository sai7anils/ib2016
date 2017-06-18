class AddTermConditionToUser < ActiveRecord::Migration
  def change
    add_column :users, :term, :boolean
  end
end
