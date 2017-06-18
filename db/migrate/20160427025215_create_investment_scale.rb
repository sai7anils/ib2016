class CreateInvestmentScale < ActiveRecord::Migration
  def change
    create_table :investment_scales do |t|
      t.integer :business_idea_id
      t.text :total_capital
      t.integer :fund_already
      t.integer :fund_like_to_invest
      t.text :fund_you_seeking
      t.string :offering_business
      t.text :use_fund
      t.timestamps null: false
    end
  end
end
