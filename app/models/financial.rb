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
#  balance_sheets     :json
#  cash_flows         :json
#  equity_debt        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Financial < ActiveRecord::Base
  belongs_to :fund_startup
  OFTEN = [['Daily', 1], ['Weekly', 2], ['Monthly', 3], ['Quartely', 4], ['Annually', 5]]
  REVENUE = [['Customers', 1], ['Transactions', 2], ['Units', 3]]
  mount_uploaders :balance_sheets, PitchBurnUploader
  mount_uploaders :cash_flows, PitchBurnUploader

  validates :revenue, presence: true, :numericality => { :greater_than => 0}
  validates :often, presence: true, :numericality => { :greater_than => 0}
  validates :previous_revenue, presence: true, :numericality => { :greater_than => 0}
  validates :current_revenue, presence: true, :numericality => { :greater_than => 0}
  validates :previous_netprofit, presence: true, :numericality => { :greater_than => 0}
  validates :crowd_funding, inclusion: { in: [ true, false ] }
  validates :put_money, inclusion: { in: [ true, false ] }
  validates :balance_sheets, presence: true
  validates :cash_flows, presence: true
  validates :equity_debt, presence: true, length: { minimum: 100, maximum: 600 }

  def revenue_in_text
    REVENUE.to_h.invert[revenue]
  end

  def often_in_text
    OFTEN.to_h.invert[often]
  end
end
