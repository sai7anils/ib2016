# == Schema Information
#
# Table name: legal_advisors
#
#  id                   :integer          not null, primary key
#  fund_startup_id      :integer
#  professional_advisor :boolean
#  board_advisor        :boolean
#  member               :integer
#  professional_advice  :integer
#  board_manager        :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe LegalAdvisor, type: :model do
  describe 'association' do
    it { should belong_to(:fund_startup) }
  end

  # describe 'validation' do
  #   it { should validate_presence_of(:professional_advisor) }
  #   it { should validate_presence_of(:board_advisor) }
  #   it { should validates_numericality_of(:member) }
  #   it { should validates_numericality_of(:professional_advice) }
  #   it { should validates_numericality_of(:board_manager) }
  # end
end
