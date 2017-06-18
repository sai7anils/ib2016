# == Schema Information
#
# Table name: investment_scales
#
#  id                  :integer          not null, primary key
#  business_idea_id    :integer
#  total_capital       :text
#  fund_already        :integer
#  fund_like_to_invest :integer
#  fund_you_seeking    :text
#  offering_business   :string
#  use_fund            :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class InvestmentScale < ActiveRecord::Base
  belongs_to :business_idea

  validates :total_capital, presence: true
  validates :fund_already, presence: true
  validates :fund_like_to_invest, presence: true
  validates :fund_you_seeking, presence: true
  validates :offering_business, presence: true
  validates :use_fund, presence: true, length: { minimum: 80, maximum: 400 }

  PERCENTAGE = (10..90).to_a
  PERCENTAGE_FUND = [10, 20, 30, 40, 50, 60, 70, 0]
end
