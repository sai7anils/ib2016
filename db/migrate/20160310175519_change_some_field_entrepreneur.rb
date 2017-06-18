class ChangeSomeFieldEntrepreneur < ActiveRecord::Migration
  def change
    change_column :entrepreneurs, :dob, :date
    change_column :entrepreneurs, :graduation, :string
  end
end
