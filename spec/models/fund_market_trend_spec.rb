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

require 'rails_helper'

RSpec.describe FundMarketTrend, type: :model do
  describe 'association' do
    it { should belong_to(:business_potential) }
  end

  # describe 'validation' do
  #   it { should validates_numericality_of(:market_growing) }
  #   it { should validates_numericality_of(:market_size) }
  #   it { should validate_presence_of(:startup_process) }
  #   it { should validate_presence_of(:describe) }
  #   it { should validate_presence_of(:approx) }
  # end
end
