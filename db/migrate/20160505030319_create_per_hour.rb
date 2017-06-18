class CreatePerHour < ActiveRecord::Migration
  def change
    create_table :per_hours do |t|
      t.integer :business_potencial_id
      t.hstore :billable, default: {}, null: false
      t.hstore :rate, default: {}, null: false
      t.timestamps null: false
    end
  end
end
