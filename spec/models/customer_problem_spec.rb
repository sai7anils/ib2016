# == Schema Information
#
# Table name: customer_problems
#
#  id                    :integer          not null, primary key
#  business_potential_id :integer
#  explain               :text
#  region                :string
#  from_age              :integer
#  to_age                :integer
#  potential_competitor  :text
#  checkout              :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe CustomerProblem, type: :model do
  describe 'association' do
    it { should belong_to(:business_potential) }
  end

  # describe 'validation' do
  #   it { should validate_presence_of(:explain) }
  #   it { should validate_presence_of(:region) }
  #   it { should validates_numericality_of(:from_age) }
  #   it { should validates_numericality_of(:to_age) }
  #   it { should validate_presence_of(:potential_competitor) }
  #   it { should validate_presence_of(:checkout) }
  # end
end
