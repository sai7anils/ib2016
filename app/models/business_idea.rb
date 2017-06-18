# == Schema Information
#
# Table name: business_ideas
#
#  id                 :integer          not null, primary key
#  idea_id            :integer
#  business_line      :integer
#  tagline            :string
#  problem_statement  :text
#  solution           :text
#  idea_stage         :string
#  ip_patent          :string
#  motivation_vision  :integer
#  year_exp           :integer
#  startup_business   :integer
#  business_model     :integer
#  des_business_model :text
#  idea_execution     :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  business_idea_type :integer
#  register_number    :string
#

class BusinessIdea < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  #after_initialize :set_defaults, unless: :persisted?
  belongs_to :idea
  has_one :market_analysis, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :market_analysis, allow_destroy: true

  has_one :customer_analysis, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :customer_analysis, allow_destroy: true

  has_one :investment_scale, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :investment_scale, allow_destroy: true

  has_one :exit_strategie, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :exit_strategie, allow_destroy: true

  has_one :business_potencial, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :business_potencial, allow_destroy: true

  has_one :pitch_burn, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :pitch_burn, allow_destroy: true

  has_one :team_cappabilitie, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :team_cappabilitie, allow_destroy: true

  has_one :competitor, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :competitor, allow_destroy: true

  validates :business_line, presence: true
  validates :tagline, presence: true
  validates :problem_statement, presence: true, length: { minimum: 80, maximum: 400 }
  validates :solution, presence: true, length: { minimum: 80, maximum: 400 }
  validates :idea_stage, presence: true
  validates :ip_patent, presence: true
  validates :motivation_vision, presence: true
  validates :year_exp, presence: true
  validates :startup_business, presence: true
  validates :business_model, presence: true
  validates :des_business_model, presence: true, length: { minimum: 80, maximum: 400 }
  validates :business_idea_type, presence: true
  validates_length_of :idea_execution, :minimum => 80, :maximum => 400, :allow_blank => true

  scope :by_business_line, -> (c){where(:business_line => c)}

  delegate :title, :description, :attachment, :username, :category_name, to: :idea

  YEARS = [['None', 0], ['0-02 Years', 1], ['05-10 Years', 2], ['10+ Years', 3]]
  STAGE_NAME = {50 => 'Generation', 60 => 'Assessment', 70 => 'Planning', 80 => 'Prototype', 90 => 'Implimentation'}
  PATENT = {100 => 'If Patented / IP', 90 => 'Pending', 30 => 'Not yet'}

  def set_defaults
    self.ip_patent = 100
  end

  def regions
    return [] if customer_analysis.nil?
    customer_analysis.region.map{ |code| CustomerAnalysis.regions.to_h[code] }
  end

  def patented_status
    PATENT[ip_patent.to_i]
  end

  def business_line_name
    BusinessLine.find(self.business_line).name if self.business_line
  end

  def idea_stage_name
    BusinessIdea::STAGE_NAME[self.idea_stage.to_i]
  end

  def motivation_vision_name
    PrimaryReason.find(self.motivation_vision).name if self.motivation_vision.present?
  end

  def year_exp_name
    BusinessIdea::YEARS[self.year_exp].first if self.year_exp.present?
  end

  def business_model_name
    BusinessModel.find(self.business_model).name if self.business_model.present?
  end

  def startup_business_name
    BusinessAnswer.find(self.startup_business).name if self.startup_business.present?
  end

  def validation_score
    primary_nicetie = self.idea_stage.to_i + self.ip_patent.to_i

    motivation_vision_arr = [0, 60, 50, 75, 100, 30]
    year_exp_arr = [50, 65, 75, 85, 95];
    startup_business_arr = [0, 50, 70, 80, 75, 65];
    business_model_arr = [0, 100, 100, 100, 0, 100];
    stage_analysis =  motivation_vision_arr[self.motivation_vision.to_i] + year_exp_arr[self.year_exp.to_i] + startup_business_arr[self.startup_business.to_i] + business_model_arr[self.business_model.to_i]
    if self.team_cappabilitie.nil?
      team = 0
    else
      crucial_skills_arr = [0, 90, 60, 70, 95, 35]
      team_attributes_arr = [0, 90, 70, 95, 65, 50]
      team = crucial_skills_arr[self.team_cappabilitie.crucial_skills.to_i] + team_attributes_arr[self.team_cappabilitie.team_attributes.to_i]
    end

    if self.market_analysis. nil?
      market = 0
    else
      market_trend_arr = [0, 40, 60, 75, 90, 10];
      market_channels_arr = [0, 70, 60, 65, 80, 75];
      market_size_arr = [0, 60, 70, 80, 90, 100];
      market = market_trend_arr[self.market_analysis.market_trend.to_i] + market_channels_arr[self.market_analysis.market_channels.to_i] + market_size_arr[self.market_analysis.market_size.to_i]
    end

    if self.customer_analysis.nil?
      customer = 0
    else
      big_customer_arr = [0, 50, 60, 70, 80, 90]
      customer = big_customer_arr[self.customer_analysis.big_customer.to_i]
    end

    if self.investment_scale.nil?
      investment = 0
    else
      fund_already_arr = {10 => 40, 20 => 45, 30 => 50, 40 => 55, 50 => 60, 60 => 65, 70 => 70, 0 => 10 }
      fund_like_to_invest_arr = {10 => 40, 20 => 45, 30 => 50, 40 => 55, 50 => 60, 60 => 65, 70 => 70, 0 => 10 }
      investment = fund_already_arr[self.investment_scale.fund_already.to_i] + fund_like_to_invest_arr[self.investment_scale.fund_like_to_invest.to_i]
    end

    sum = primary_nicetie + stage_analysis +  team + market + customer + investment
    percent = sum.to_f / 1400.to_f
    [number: (percent*100).round(0) , text: number_to_percentage(percent*100, precision: 0)]
  end

  def learn_more_url(user)
    if user.entrepreneur?
      Rails.application.routes.url_helpers.user_business_idea_path(self.idea)
    elsif user.investor?
      if user.investor && user.investor.verified?
        access_url(true, self.idea)
      else
        access_url(false, self.idea)
      end
    end
  end

  def access_learn_more?(user)
    user.entrepreneur? && self.idea.user == user ||
    user.investor? && user.investor && user.investor.verified?
  end

  def self.search_by_keyword(keyword)
    return all if keyword.blank?

    bi = self.arel_table
    i = Idea.arel_table
    u = User.arel_table
    ca = CustomerAnalysis.arel_table

    query_string = "%#{keyword}%"
    category_ids = Category.all.select{ |cat| cat.name.include? keyword }.map(&:id)
    region_codes = CustomerAnalysis.regions.select{ |reg| reg.last.include? keyword }.map(&:first)
    region_codes = nil if region_codes.empty?

    joins(:customer_analysis, idea: :user).where(
      bi[:tagline].matches(query_string)
      .or(bi[:problem_statement].matches(query_string))
      .or(bi[:solution].matches(query_string))
      .or(i[:title].matches(query_string))
      .or(i[:category_id].in(category_ids))
      .or(u[:username].matches(query_string))
      .or(ca[:region].contains(region_codes))
    )
  end

end
