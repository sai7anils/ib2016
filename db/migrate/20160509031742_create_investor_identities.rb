class CreateInvestorIdentities < ActiveRecord::Migration
  def change
    create_table :investor_identities do |t|
      t.integer :investor_id
      t.string :nationality_identity_proof
      t.string :unique_identity_document
      t.string :previous_invesment_proofs

      t.timestamps null: false
    end
  end
end
