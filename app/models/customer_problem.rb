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

class CustomerProblem < ActiveRecord::Base
  belongs_to :business_potential
  serialize :region, Array

  FROM = (1..99).to_a
  TO = (1..99).to_a
  TARGET = [['Intermittent growth', 1], ['NorthAmerica', 2], ['MiddleEast', 3]]
  REGION = [['AsiaPacific'], ['Europe'], ['Africa'], ['SouthAmerica'], ['NorthAmerica'], ['MiddleEast'], ['SouthEastAsia']]

  validates :explain, presence: true, length: { minimum: 100, maximum: 600 }
  validates :region, presence: true
  validates :from_age, presence: true, :numericality => { :greater_than => 0}
  validates :to_age, presence: true, :numericality => { :greater_than => 0}
  validates :potential_competitor, presence: true, length: { minimum: 100, maximum: 600 }
  validates :checkout, inclusion: { in: [ true, false ] }

  def target_regions
    region.join(', ')
  end

  def potential_customer_feedback_in_text
    if checkout
      'Yes, we are taken and proccessing.'
    else
      'No. Not yet.'
    end
  end
end
