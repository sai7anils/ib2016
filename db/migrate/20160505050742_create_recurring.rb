class CreateRecurring < ActiveRecord::Migration
  def change
    create_table :recurrings do |t|
      t.integer :business_potencial_id
      t.hstore :no_account, default: {}, null: false
      t.hstore :charge, default: {}, null: false
      t.hstore :churn_rate, default: {}, null: false
      t.timestamps null: false
    end
  end
end
