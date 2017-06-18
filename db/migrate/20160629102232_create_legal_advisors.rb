class CreateLegalAdvisors < ActiveRecord::Migration
  def change
    create_table :legal_advisors do |t|
      t.integer :fund_startup_id
      t.boolean :professional_advisor
      t.boolean :board_advisor
      t.integer :member
      t.integer :professional_advice
      t.integer :board_manager

      t.timestamps null: false
    end
  end
end
