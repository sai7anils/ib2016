class RemoveSomeColumn < ActiveRecord::Migration
  def change
    remove_column :business_potencials, :per_unit
  end
end
