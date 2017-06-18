class AddPurchasedAtAndStatusToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :purchased_at, :datetime
    add_column :ideas, :status, :string
  end
end
