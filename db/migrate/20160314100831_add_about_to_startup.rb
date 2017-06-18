class AddAboutToStartup < ActiveRecord::Migration
  def change
    add_column :startups, :about, :text
  end
end
