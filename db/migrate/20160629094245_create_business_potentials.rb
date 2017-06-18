class CreateBusinessPotentials < ActiveRecord::Migration
  def change
    create_table :business_potentials do |t|
      t.integer :fund_startup_id

      t.timestamps null: false
    end
  end
end
