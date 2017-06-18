class CreateBusinessModels < ActiveRecord::Migration
  def change
    create_table :business_models do |t|
      t.integer :business_potential_id
      t.integer :type
      t.integer :subtype
      t.text :startup_process
      t.text :mvp

      t.timestamps null: false
    end
  end
end
