# == Schema Information
#
# Table name: fund_market_trends
#
#  id                    :integer          not null, primary key
#  business_potential_id :integer
#  market_growing        :integer
#  startup_process       :text
#  market_size           :integer
#  describe              :text
#  approx                :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class FundMarketTrend < ActiveRecord::Base
  belongs_to :business_potential
  validates :market_growing, presence: true, :numericality => { :greater_than => 0}
  validates :startup_process, presence: true, length: { minimum: 100, maximum: 600 }
  validates :market_size, presence: true, :numericality => { :greater_than => 0}
  validates :describe, presence: true, length: { minimum: 100, maximum: 600 }
  validates :approx, presence: true

  alias_attribute :sales_plan, :describe

  MARKET_TREND = [['Low Growth', 1], ['Intermittent growth', 2], ['Steady Growth', 3], ['Rapid Growth', 4], ['Yet to be Analyzed', 5]]
  MARKET_SIZE = [['Under $1M', 1], ['$1M - $10M', 2], ['$10M - $50M', 3], ['$50M - $250M', 4], ['$250M+', 5]]

  def market_growing_in_text
    MARKET_TREND.to_h.invert[market_growing]
  end

  def market_size_in_text
    MARKET_SIZE.to_h.invert[market_size]
  end
end
