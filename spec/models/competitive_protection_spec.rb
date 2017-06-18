# == Schema Information
#
# Table name: competitive_protections
#
#  id                    :integer          not null, primary key
#  business_potential_id :integer
#  strategy              :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe CompetitiveProtection, type: :model do
  describe 'association' do
    it { should belong_to(:business_potential) }
    # it { should have_many(:competitor_teams) }
  end

  describe 'validation' do
    # it { should validate_presence_of(:strategy) }
  end
end
