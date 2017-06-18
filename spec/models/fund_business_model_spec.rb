# == Schema Information
#
# Table name: fund_business_models
#
#  id                    :integer          not null, primary key
#  business_potential_id :integer
#  type                  :integer
#  subtype               :integer
#  startup_process       :text
#  mvp                   :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe FundBusinessModel, type: :model do
  describe 'association' do
    it { should belong_to(:business_potential) }
  end

  # describe 'validation' do
  #   it { should validates_numericality_of(:type) }
  #   it { should validates_numericality_of(:subtype) }
  #   it { should validate_presence_of(:startup_process) }
  #   it { should validate_presence_of(:mvp) }
  # end
end
