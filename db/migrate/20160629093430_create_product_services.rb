class CreateProductServices < ActiveRecord::Migration
  def change
    create_table :product_services do |t|
      t.text :about
      t.integer :primary_business
      t.string :name
      t.integer :type
      t.integer :subtype
      t.text :description
      t.text :product_competitive
      t.integer :fund_startup_id

      t.timestamps null: false
    end
  end
end
