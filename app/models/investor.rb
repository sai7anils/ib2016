# == Schema Information
#
# Table name: investors
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  name              :string
#  founded           :integer
#  category          :integer
#  website           :string
#  mission           :text
#  work              :text
#  register_under    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  address_line_1    :string
#  address_line_2    :string
#  facebook          :string
#  twitter           :string
#  linkedin          :string
#  ios_app           :string
#  adroid_app        :string
#  windows_app       :string
#  business_line     :integer          default([]), is an Array
#  investor_type     :integer
#  first_name        :string
#  last_name         :string
#  gender            :boolean
#  dob               :date
#  website_secondary :string
#  skype             :string
#  email_confirm     :text
#  confirm_token     :string
#

require 'digest/md5'

class Investor < ActiveRecord::Base
  belongs_to :user
  has_many :investor_teams
  has_many :portfolios
  has_one :investor_identity
  serialize :email_confirm

  accepts_nested_attributes_for :investor_teams, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :portfolios, reject_if: :all_blank, allow_destroy: true

  TYPE_OPTIONS = [["- Select Investor Type -", nil], ["Individual", 1], ["Angel Investor", 2], ["Accerlator ", 3], ["Angel Group", 4], ["Government Organizations", 5], ["Non-Profit Organisation ", 6], ["Startup Incubator", 7], ["Venture Capital", 8], ["Others", 9]]
  FUNDING_OPTIONS = [["- Select Type of Funding -", nil], ["CrowdFunding", 1], [" Series A", 2], ["Series B", 3], ["Series C", 4], ["Series D", 5], ["Series E", 6], ["Bridge /Loan", 7], ["Others", 8]]
  DESIGNATION_OPTIONS = [["- Select Designation -", nil], ["Director", 1], ["Partner", 2], ["Investment analyst", 3], ["Investment advisor", 4], ["Finance professional", 5], ["Others", 6]]

  TYPES = [[nil, nil], ["Individual", 1], ["Angel Investor", 2], ["Accerlator ", 3], ["Angel Group", 4], ["Government Organizations", 5], ["Non-Profit Organisation ", 6], ["Startup Incubator", 7], ["Venture Capital", 8], ["Others", 9]]

  FUNDINGS = [[nil, nil], ["CrowdFunding", 1], [" Series A", 2], ["Series B", 3], ["Series C", 4], ["Series D", 5], ["Series E", 6], ["Bridge /Loan", 7], ["Others", 8]]

  DESIGNATIONS = [[nil, nil], ["Director", 1], ["Partner", 2], ["Investment analyst", 3], ["Investment advisor", 4], ["Finance professional", 5], ["Others", 6]]

  def email_activate
    self.email_confirm = ["#{self.investor_identity.id}":"true"]
    self.confirm_token = nil
    save!(:validate => false)
  end

  def type_name
    TYPES[self.investor_type][0] if self.investor_type
  end

  def business_type
    if self.business_line.present?
      self.business_line.map {|i| BusinessLine[i].name unless i.nil?}.compact.join(', ')
    end
  end

  def funding_name
     FUNDINGS[self.funding_round.to_i][0] if self.funding_round
  end

  def designation_name
    DESIGNATIONS[self.team_designation][0] if self.team_designation
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def verified?
    if self.email_confirm.present?
      true
    else
      false
    end
  end

  def self.by_investor_type(users, type)
    users.joins(:investor).where(:investors => {:investor_type => type})
  end

  def self.by_business_line(users, line)
  # users.where("business_line like '%#{line}%'")
    users = users.order('created_at desc')
    users.each_with_index do |user, index|
      if user.investor.business_line.present?
        user.investor.business_line.include?(line) ? users : users[index] = nil
      else
        users[index] = nil
      end
    end
    users = users.compact
  end

  def self.year_options
    [["- Select Founded Year -", nil]].concat((1982..2016).collect{|y| "#{y}" })
  end

  def self.designation_options
    DESIGNATION_OPTIONS
  end

  def self.type_of_funding_options
    FUNDING_OPTIONS
  end

  def self.type_options
    TYPE_OPTIONS
  end

  def self.search(params)
    results = all
    if params[:query].present?
      results = results.joins(:user).where("users.username LIKE :query OR users.email LIKE :query", query: "%#{params[:query]}%")
    end
    if params[:location].present?
      results = results.joins(:user).where("users.country LIKE :location OR users.city LIKE :location OR users.region LIKE :location", { location: "%#{params[:location]}%" })
    end
    if params[:gender].present?
      results = results.where(gender: params[:gender])
    end
    if params[:dob].present?
      dob = Date.parse(params[:dob]) rescue nil
      results = results.where(dob: params[:dob]) if dob
    end
    if params[:business_line].present?
      results = results.where("'#{params[:business_line]}' = ANY(business_line)" )
    end
    if params[:investor_type].present?
      results = results.where(investor_type: params[:investor_type])
    end
    if params[:address].present?
      results = results.where("address_line_1 LIKE :address OR address_line_2 LIKE :address", address: "%#{params[:address]}%")
    end
    results
  end

end
