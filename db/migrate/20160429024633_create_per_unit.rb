class CreatePerUnit < ActiveRecord::Migration
  def change
    create_table :per_units do |t|
      t.integer :business_potencial_id
      t.hstore :sale, default: {}, null: false
      t.hstore :price, default: {}, null: false
      t.timestamps null: false
    end
  end
end
