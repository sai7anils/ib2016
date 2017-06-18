class RenameEventSubtype < ActiveRecord::Migration
  def change
    rename_column :events, :event_sub_type, :event_category
  end
end
