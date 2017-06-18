class AddSkypeToEntrepreneur < ActiveRecord::Migration
  def change
    add_column :entrepreneurs, :skype, :string
  end
end
