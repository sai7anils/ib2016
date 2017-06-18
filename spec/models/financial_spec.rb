# == Schema Information
#
# Table name: financials
#
#  id                 :integer          not null, primary key
#  fund_startup_id    :integer
#  revenue            :integer
#  often              :integer
#  previous_revenue   :integer
#  current_revenue    :integer
#  previous_netprofit :integer
#  crowd_funding      :boolean
#  put_money          :boolean
#  balance_sheet      :string
#  cash_flow          :string
#  equity_debt        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Financial, type: :model do
  describe 'association' do
    it { should belong_to(:fund_startup) }
  end

  # describe 'validation' do
  #   it { should validate_presence_of(:revenue) }
  #   it { should validate_presence_of(:balance_sheet) }
  #   it { should validate_presence_of(:cash_flow) }
  #   it { should validate_presence_of(:equity_debt) }
  #   it { should validate_presence_of(:put_money) }
  #   it { should validate_presence_of(:crowd_funding) }
  #   it { should validates_numericality_of(:often) }
  #   it { should validates_numericality_of(:previous_revenue) }
  #   it { should validates_numericality_of(:current_revenue) }
  #   it { should validates_numericality_of(:previous_netprofit) }
  # end
end
