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

class FundBusinessModel < ActiveRecord::Base
  belongs_to :business_potential
  self.inheritance_column = nil

  validates :type, presence: true, :numericality => { :greater_than => 0}
  validates :subtype, presence: true, :numericality => { :greater_than => 0}
  validates :startup_process, presence: true, length: { minimum: 100, maximum: 600 }
  validates :mvp, presence: true, length: { minimum: 100, maximum: 600 }

  TYPE_BUSINESS_MODEL = [['B2B', 1], ['B2C', 2]]
  SUBTYPE_BUSINESS_MODEL = [['Licencing', 1], ['Subscription', 2], ['Commerce', 3], ['Advertising', 4], ['Peer to Peer', 5], ['Confidential', 6]]

  def business_type_name
    FundBusinessModel::TYPE_BUSINESS_MODEL.to_h.invert[self.type]
  end

  def business_subtype_name
    FundBusinessModel::SUBTYPE_BUSINESS_MODEL.to_h.invert[self.subtype]
  end

end
