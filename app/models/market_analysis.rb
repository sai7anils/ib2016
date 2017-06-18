# == Schema Information
#
# Table name: market_analyses
#
#  id                  :integer          not null, primary key
#  business_idea_id    :integer
#  is_new              :boolean
#  have_major          :boolean
#  market_channels     :integer
#  market_size         :integer
#  market_analyses_des :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  market_trend        :integer
#

class MarketAnalysis < ActiveRecord::Base
  belongs_to :business_idea

  validates_inclusion_of :is_new, :in => [true, false]
  validates_inclusion_of :have_major, :in => [true, false]
  validates :market_channels, presence: true
  validates :market_size, presence: true
  validates :market_analyses_des, presence: true, length: { minimum: 80, maximum: 400 }
  validates :market_trend, presence: true

  def market_trend_name
    MarketTrend.find(self.market_trend).name if self.market_trend.present?
  end

  def market_channels_name
    MarketChannel.find(self.market_channels).name if self.market_channels.present?
  end

  def market_size_name
    MarketSize.find(self.market_size).name if self.market_size.present?
  end

  def is_new_name
    self.is_new.nil? ? 'No' : (self.is_new ? 'Yes' : 'No')
  end

  def have_major_name
    self.have_major.nil? ? 'No' : (self.have_major ? 'Yes' : 'No')
  end
end
