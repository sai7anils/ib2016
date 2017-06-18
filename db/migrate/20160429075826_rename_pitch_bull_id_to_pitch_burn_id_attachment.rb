class RenamePitchBullIdToPitchBurnIdAttachment < ActiveRecord::Migration
  def change
    rename_column :attachments, :pitch_bull_id, :pitch_burn_id
  end
end
