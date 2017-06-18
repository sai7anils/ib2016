class CreateCustomerProblems < ActiveRecord::Migration
  def change
    create_table :customer_problems do |t|
      t.integer :business_potential_id
      t.text :explain
      t.string :region
      t.integer :from_age
      t.integer :to_age
      t.text :potential_competitor
      t.boolean :checkout

      t.timestamps null: false
    end
  end
end
