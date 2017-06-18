class ChangeInvestorBusinessLineToArray < ActiveRecord::Migration
  def change
    change_column :investors, :business_line, "integer[] USING (string_to_array(business_line, ',')::integer[])", default: []
  end
end
