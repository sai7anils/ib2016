# == Schema Information
#
# Table name: portfolios
#
#  id            :integer          not null, primary key
#  name          :string
#  website       :string
#  fundding_type :integer
#  amount        :string
#  logo          :string
#  investor_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Portfolio < ActiveRecord::Base
  belongs_to :investor

  mount_uploader :logo, InvestorUploader

  FUNDINGS = [[nil, nil], ["CrowdFunding", 3], [" Series A", 4], ["Series B", 5], ["Series C", 6], ["Series D", 7], ["Series E", 8], ["Bridge /Loan", 9], ["Others", 11]]

  def type_name
    FUNDINGS[self.fundding_type.to_i][0] if self.fundding_type
  end
end
