class RenameTypePortfolio < ActiveRecord::Migration
  def change
    rename_column :portfolios, :type, :fundding_type
  end
end
