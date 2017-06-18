class CreateFundStartups < ActiveRecord::Migration
  def change
    create_table :fund_startups do |t|
      t.integer :startup_id
      t.integer :views

      t.timestamps null: false
    end
  end
end
