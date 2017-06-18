class RenameTypeToEntrepreneurType < ActiveRecord::Migration
  def change
    rename_column :entrepreneurs, :type, :entrepreneur_type
  end
end
