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

class ProductService < ActiveRecord::Base
  belongs_to :fund_startup
  self.inheritance_column = nil

  validates :name, presence: true
  validates :primary_business, presence: true, :numericality => { :greater_than => 0}
  validates :about, presence: true, length: { minimum: 100, maximum: 600 }
  validates :description, presence: true, length: { minimum: 100, maximum: 300 }
  validates :type, presence: true, :numericality => { :greater_than => 0}
  validates :product_competitive, presence: true, length: { minimum: 100, maximum: 300 }
  validates :subtype, presence: true, :numericality => { :greater_than => 0}
  FROM = (1..99).to_a

  OFFERING = [['Product', 1], ['Services', 2]]
  PRODUCT_TYPE = [['Software', 1], ['Hardware', 2], ['Non-Profit', 3]]
  PRODUCT_SUBTYPE = [['Consumer', 1], ['Customer', 2], ['Enterprise', 3]]

  def offering_type_name
    ProductService::OFFERING.to_h.invert[self.primary_business]
  end

  def product_type
    ProductService::PRODUCT_TYPE.to_h.invert[self.type]
  end

  def product_subtype
    ProductService::PRODUCT_SUBTYPE.to_h.invert[self.subtype]
  end

end
