class ChangeCustomerAnalysisRegionTypeToArray < ActiveRecord::Migration
  def change
    change_column :customer_analyses, :region, "varchar[] USING (string_to_array(region, ','))", default: []
    add_index :customer_analyses, :region, using: :gin
  end
end
