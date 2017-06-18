class AddTypeFieldToInvester < ActiveRecord::Migration
  def change
    add_column :investors, :type, :integer
  end
end
