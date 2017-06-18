class AddSomeFieldsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :idea_id, :integer
    add_column :messages, :seen, :boolean, default: false
  end
end
