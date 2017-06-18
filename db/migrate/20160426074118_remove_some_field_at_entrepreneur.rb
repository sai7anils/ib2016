class RemoveSomeFieldAtEntrepreneur < ActiveRecord::Migration
  def up
    remove_column :entrepreneurs, :entrepreneur_type
    remove_column :entrepreneurs, :age
  end
  def down
    add_column :entrepreneurs, :entrepreneur_type
    add_column :entrepreneurs, :age
  end
end
