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

require 'rails_helper'

RSpec.describe Valuation, type: :model do
  describe 'association' do
    it { should belong_to(:fund_startup) }
  end

  # describe 'validation' do
  #   it { should validates_numericality_of(:currently_outstanding) }
  #   it { should validates_numericality_of(:total_fund) }
  #   it { should validates_numericality_of(:seeking) }
  #   it { should validates_numericality_of(:pre_money) }
  #   it { should validates_numericality_of(:business_stake) }
  #   it { should validate_presence_of(:use_fund) }
  # end
end
