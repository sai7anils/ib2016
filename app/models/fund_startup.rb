# == Schema Information
#
# Table name: fund_startups
#
#  id         :integer          not null, primary key
#  startup_id :integer
#  views      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FundStartup < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  #after_initialize :set_defaults, unless: :persisted?
  belongs_to :startup
  has_one :product_service, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :product_service, allow_destroy: true

  has_one :business_potential, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :business_potential, allow_destroy: true

  has_one :fund_pitch_burn, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :fund_pitch_burn, allow_destroy: true

  has_one :valuation, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :valuation, allow_destroy: true

  has_one :legal_advisor, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :legal_advisor, allow_destroy: true

  has_one :financial, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :financial, allow_destroy: true

  delegate :user, to: :startup, allow_nil: true
  delegate :avatar, to: :user, prefix: true
  delegate :username, to: :user
  delegate :location, to: :startup, prefix: true
  delegate :website, to: :startup, prefix: true
  delegate :founded, to: :startup, prefix: true
  delegate :category_name, to: :startup, prefix: true
  delegate :about, to: :product_service, prefix: true
  delegate :offering_type_name, to: :product_service, prefix: true
  delegate :name, to: :product_service, prefix: true
  delegate :product_type, to: :product_service, prefix: true
  delegate :product_subtype, to: :product_service, prefix: true
  delegate :description, to: :product_service, prefix: true
  delegate :product_competitive, to: :product_service, prefix: true
  delegate :business_type_name, to: :business_potential, allow_nil: true
  delegate :business_subtype_name, to: :business_potential, allow_nil: true
  delegate :fund_business_model_startup_process, to: :business_potential, allow_nil: true
  delegate :mvp, to: :business_potential, allow_nil: true
  delegate :market_growing_in_text, to: :business_potential, allow_nil: true
  delegate :market_size_in_text, to: :business_potential, allow_nil: true
  delegate :approx, to: :business_potential, allow_nil: true
  delegate :sales_plan, to: :business_potential, allow_nil: true
  delegate :fund_market_trend_startup_process, to: :business_potential, allow_nil: true
  delegate :customer_target_regions, to: :business_potential, allow_nil: true
  delegate :customer_from_age, to: :business_potential, allow_nil: true
  delegate :customer_to_age, to: :business_potential, allow_nil: true
  delegate :potential_customer_feedback_in_text, to: :business_potential, allow_nil: true
  delegate :customer_problem_explain, to: :business_potential, allow_nil: nil
  delegate :potential_competitor, to: :business_potential, allow_nil: nil
  delegate :competitive_protection_strategy, to: :business_potential, allow_nil: nil
  delegate :competitor_teams, to: :business_potential, allow_nil: nil
  delegate :professional_advisor, to: :legal_advisor, prefix: true
  delegate :board_advisor, to: :legal_advisor, prefix: true
  delegate :member, to: :legal_advisor, prefix: true
  delegate :professional_advice, to: :legal_advisor, prefix: true
  delegate :board_manager, to: :legal_advisor, prefix: true
  delegate :revenue_in_text, to: :financial, prefix: true
  delegate :often_in_text, to: :financial, prefix: true
  delegate :current_revenue, to: :financial, prefix: true
  delegate :previous_netprofit, to: :financial, prefix: true
  delegate :previous_revenue, to: :financial, prefix: true
  delegate :crowd_funding, to: :financial, prefix: true
  delegate :put_money, to: :financial, prefix: true
  delegate :equity_debt, to: :financial, prefix: true
  delegate :balance_sheets, to: :financial, prefix: true
  delegate :cash_flows, to: :financial, prefix: true
  delegate :total_fund, to: :valuation, prefix: true
  delegate :currently_outstanding, to: :valuation, prefix: true
  delegate :capital_type_name, to: :valuation, prefix: true
  delegate :pre_money, to: :valuation, prefix: true
  delegate :business_stake, to: :valuation, prefix: true
  delegate :use_fund, to: :valuation, prefix: true
  delegate :prefer_exit_in_text, to: :fund_pitch_burn, prefix: true
  delegate :validation, to: :fund_pitch_burn, prefix: true
  delegate :pitch, to: :fund_pitch_burn, prefix: true
  delegate :video, to: :fund_pitch_burn, prefix: true
  delegate :attachments, to: :fund_pitch_burn, prefix: true

  def count_view
    self.views ? self.update_attributes(views: self.views + 1) :self.update_attributes(views: 0)
  end
end
