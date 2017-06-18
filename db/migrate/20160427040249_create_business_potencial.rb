class CreateBusinessPotencial < ActiveRecord::Migration
  def change
    create_table :business_potencials do |t|
      t.integer :business_idea_id
      t.integer :projection_type
      t.integer :term_number
      t.integer :revenue_type
      t.string :per_unit
      t.string :per_hour
      t.string :recurring
      t.string :own_model
      t.timestamps null: false
    end
  end
end
