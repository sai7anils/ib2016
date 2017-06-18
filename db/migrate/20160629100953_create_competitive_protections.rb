class CreateCompetitiveProtections < ActiveRecord::Migration
  def change
    create_table :competitive_protections do |t|
      t.integer :business_potential_id
      t.text :strategy

      t.timestamps null: false
    end
  end
end
