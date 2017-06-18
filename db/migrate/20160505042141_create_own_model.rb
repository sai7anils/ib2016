class CreateOwnModel < ActiveRecord::Migration
  def change
    create_table :own_models do |t|
      t.integer :business_potencial_id
      t.hstore :revenue, default: {}, null: false
      t.timestamps null: false
    end
  end
end
