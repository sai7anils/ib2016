# == Schema Information
#
# Table name: fund_pitch_burns
#
#  id              :integer          not null, primary key
#  fund_startup_id :integer
#  pitch           :string
#  video           :string
#  document        :string
#  prefer_exit     :integer
#  validation      :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe FundPitchBurn, type: :model do
  describe 'association' do
    it { should have_many(:attachments) }
    it { should belong_to(:fund_startup) }
  end

  # describe 'validation' do
  #   it { should validate_presence_of(:pitch) }
  #   it { should validate_presence_of(:video) }
  #   it { should validate_presence_of(:document) }
  #   it { should validate_presence_of(:prefer_exit) }
  #   it { should validate_presence_of(:validation) }
  # end

end
