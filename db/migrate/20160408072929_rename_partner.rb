class RenamePartner < ActiveRecord::Migration
  def change
    rename_table :partner_tables, :partners
  end
end
