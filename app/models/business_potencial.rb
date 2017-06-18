# == Schema Information
#
# Table name: business_potencials
#
#  id               :integer          not null, primary key
#  business_idea_id :integer
#  projection_type  :integer
#  term_number      :integer
#  revenue_type     :integer
#  per_hour         :string
#  recurring        :string
#  own_model        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class BusinessPotencial < ActiveRecord::Base
  belongs_to :business_idea
  has_one :per_unit, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :per_unit, allow_destroy: true

  has_one :per_hour, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :per_hour, allow_destroy: true

  has_one :own_model, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :own_model, allow_destroy: true

  has_one :recurring, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :recurring, allow_destroy: true

  validates :projection_type, presence: true
  validates :term_number, presence: true
  validates :revenue_type, presence: true

  PROJECTIONS = [['Monthly', 1], ['Year', 2]]
  PROJECTIONS_NAME = [[nil, 0], ['Monthly', 1], ['Year', 2]]
  TERMS = [['1 year', 1], ['3 years', 3], ['5 years', 5]]
  TERMS_NAME = [[nil, 0], ['1 <p>Year</p>', 1], [nil, 2], ['3 <p>Years</p>', 3], [nil, 4], ['5 Years', 5]]
  REVENUES = [['Per Unit', 1], ['Per Hour', 2], ['Recurring', 3], ['Own Model', 4]]
  REVENUES_NAME = [[nil, 0], ['Per <p>Unit</p>', 1], ['Per <p>Hour</p>', 2], ['Recurring', 3], ['Own <p>Model</p>', 4]]
  PER_UNIT = [['Sales in Number of units', 1], ['Prices per each sale', 2]]
  PER_HOUR = [['Billable hours', 1], ['Hourly Rate', 2]]
  RECURRING = [['No of Accounts', 1], ['Charges', 2], ['Churn Rate', 3]]
  OWN_MODEL = [['Revenue', 1]]

  def projection_type_name
    BusinessPotencial::PROJECTIONS_NAME[self.projection_type].first if self.projection_type.present?
  end

  def term_number_name
    BusinessPotencial::TERMS_NAME[self.term_number].first if self.term_number.present?
  end

  def revenue_type_name
    BusinessPotencial::REVENUES_NAME[self.revenue_type].first if self.revenue_type.present?
  end
end
