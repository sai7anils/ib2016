class RenameFromToCustomerAnalysis < ActiveRecord::Migration
  def change
    rename_column :customer_analyses, :from_to, :to_age
  end
end
