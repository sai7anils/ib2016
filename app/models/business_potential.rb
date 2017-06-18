# == Schema Information
#
# Table name: business_potentials
#
#  id              :integer          not null, primary key
#  fund_startup_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class BusinessPotential < ActiveRecord::Base
  has_one :competitive_protection, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :competitive_protection, allow_destroy: true

  has_one :customer_problem, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :customer_problem, allow_destroy: true

  has_one :fund_market_trend, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :fund_market_trend, allow_destroy: true

  has_one :fund_business_model, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :fund_business_model, allow_destroy: true

  belongs_to :fund_startup

  delegate :business_type_name, to: :fund_business_model
  delegate :business_subtype_name, to: :fund_business_model
  delegate :startup_process, to: :fund_business_model, prefix: true
  delegate :mvp, to: :fund_business_model
  delegate :market_growing_in_text, to: :fund_market_trend
  delegate :market_size_in_text, to: :fund_market_trend
  delegate :approx, to: :fund_market_trend
  delegate :sales_plan, to: :fund_market_trend
  delegate :startup_process, to: :fund_market_trend, prefix: true
  delegate :target_regions, to: :customer_problem, prefix: :customer
  delegate :from_age, to: :customer_problem, prefix: :customer
  delegate :to_age, to: :customer_problem, prefix: :customer
  delegate :potential_customer_feedback_in_text, to: :customer_problem
  delegate :explain, to: :customer_problem, prefix: true
  delegate :potential_competitor, to: :customer_problem
  delegate :strategy, to: :competitive_protection, prefix: true
  delegate :competitor_teams, to: :competitive_protection

end
