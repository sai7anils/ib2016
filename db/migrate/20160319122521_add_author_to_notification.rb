class AddAuthorToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :author, :integer
  end
end
