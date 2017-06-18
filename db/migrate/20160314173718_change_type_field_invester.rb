class ChangeTypeFieldInvester < ActiveRecord::Migration
  def change
    rename_column :investors, :type, :investor_type
  end
end
