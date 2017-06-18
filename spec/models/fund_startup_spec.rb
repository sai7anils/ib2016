# == Schema Information
#
# Table name: fund_startups
#
#  id         :integer          not null, primary key
#  startup_id :integer
#  views      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FundStartup, type: :model do
  describe 'association' do
    it { should have_one(:product_service) }
    it { should have_one(:business_potential) }
    it { should have_one(:fund_pitch_burn) }
    it { should have_one(:valuation) }
    it { should have_one(:legal_advisor) }
    it { should have_one(:financial) }
  end

  # describe 'validation' do
  #   it { should validate_presence_of(:startup_id) }
  #   it { should validate_presence_of(:view) }
  # end

end
