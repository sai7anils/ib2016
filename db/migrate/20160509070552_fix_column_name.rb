class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :attachments, :invester_identity_id, :investor_identity_id
  end
end
