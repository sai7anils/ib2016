class CreateCustomerAnalysis < ActiveRecord::Migration
  def change
    create_table :customer_analyses do |t|
      t.integer :business_idea_id
      t.text :idea_solve
      t.string :big_customer
      t.text :about
      t.string :region
      t.datetime :from_age
      t.datetime :from_to
      t.text :steps
      t.timestamps null: false
    end
  end
end
