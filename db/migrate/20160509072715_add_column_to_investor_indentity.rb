class AddColumnToInvestorIndentity < ActiveRecord::Migration
  def change
    add_column :investor_identities, :indentity_proof, :string
  end
end
