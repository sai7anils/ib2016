# == Schema Information
#
# Table name: product_services
#
#  id                  :integer          not null, primary key
#  about               :text
#  primary_business    :integer
#  name                :string
#  type                :integer
#  subtype             :integer
#  description         :text
#  product_competitive :text
#  fund_startup_id     :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe ProductService, type: :model do
  describe 'association' do
    it { should belong_to(:fund_startup) }
  end

  # describe 'validation' do
  #   it { should validate_presence_of(:about) }
  #   it { should validate_presence_of(:primary_business) }
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:type) }
  #   it { should validate_presence_of(:subtype) }
  #   it { should validate_presence_of(:description) }
  #   it { should validate_presence_of(:product_competitive) }
  # end

end
