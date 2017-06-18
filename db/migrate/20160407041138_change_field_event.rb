class ChangeFieldEvent < ActiveRecord::Migration
  def change
    rename_column :events, :paid_entry_cose_min, :paid_entry_cost_min
    add_column :events, :event_time, :datetime
  end
end
