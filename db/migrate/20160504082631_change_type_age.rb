class ChangeTypeAge < ActiveRecord::Migration
  def change
    change_column :customer_analyses, :from_age, :string
    change_column :customer_analyses, :to_age, :string
  end
end
