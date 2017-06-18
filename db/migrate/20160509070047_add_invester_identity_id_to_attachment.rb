class AddInvesterIdentityIdToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :invester_identity_id, :integer
  end
end
