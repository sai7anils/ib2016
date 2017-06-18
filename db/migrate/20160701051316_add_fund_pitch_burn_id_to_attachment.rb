class AddFundPitchBurnIdToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :fund_pitch_burn_id, :integer
  end
end
