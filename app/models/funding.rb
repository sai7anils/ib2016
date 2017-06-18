# == Schema Information
#
# Table name: fundings
#
#  id           :integer          not null, primary key
#  funding_type :integer
#  amount       :integer
#  date         :date
#  by_investor  :string
#  startup_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Funding < ActiveRecord::Base
  belongs_to :startup

  FUNDING_OPTIONS = [ [" No Funding", 1], ["Bootstrap", 2], ["CrowdFunding", 3], [" Series A", 4], ["Series B", 5], ["Series C", 6], ["Series D", 7], ["Series E", 8], ["Bridge /Loan", 9], ["Friends/Family", 10], ["Others", 11]]

  FUNDING_NAME = [[nil, nil], [" No Funding", 1], ["Bootstrap", 2], ["CrowdFunding", 3], [" Series A", 4], ["Series B", 5], ["Series C", 6], ["Series D", 7], ["Series E", 8], ["Bridge /Loan", 9], ["Friends/Family", 10], ["Others", 11]]
  def self.type_of_funding_options
    FUNDING_OPTIONS
  end

  def funding_name
    FUNDING_NAME[self.funding_type][0] if self.funding_type
  end
end
