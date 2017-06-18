# == Schema Information
#
# Table name: valuations
#
#  id                    :integer          not null, primary key
#  fund_startup_id       :integer
#  currently_outstanding :integer
#  total_fund            :integer
#  seeking               :integer
#  pre_money             :integer
#  business_stake        :integer
#  use_fund              :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Valuation < ActiveRecord::Base
  belongs_to :fund_startup

  PERCENTAGE = (1..90).to_a
  TYPE_CAPITAL = [['Equity', 1], ['Convertible Debt', 2], ['Debt Financing', 3], ['Grant', 4], ['Royalty', 5], ['Others', 6]]
  validates :use_fund, presence: true, length: { minimum: 100, maximum: 600 }
  validates :currently_outstanding, presence: true, :numericality => { :greater_than => 0}
  validates :total_fund, presence: true, :numericality => { :greater_than => 0}
  validates :seeking, presence: true, :numericality => { :greater_than => 0}
  validates :pre_money, presence: true, :numericality => { :greater_than => 0}
  validates :business_stake, presence: true, :numericality => { :greater_than => 0}

  def capital_type_name
    Valuation::TYPE_CAPITAL.to_h.invert[seeking]
  end
end
