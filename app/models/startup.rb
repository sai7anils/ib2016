# == Schema Information
#
# Table name: startups
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  name             :string
#  founded          :string
#  category         :integer
#  website          :string
#  strength         :string
#  mission          :text
#  work             :text
#  register_under   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reg_company_name :string
#  facebook         :string
#  twitter          :string
#  linkedin         :string
#  ios_app          :string
#  adroid_app       :string
#  window_app       :string
#  address_line_1   :string
#  address_line_2   :string
#  about            :text
#

class Startup < ActiveRecord::Base
  belongs_to :user
  has_many :teams
  has_many :fundings
  has_many :fund_startups, dependent: :destroy
  accepts_nested_attributes_for :teams, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :fundings, reject_if: :all_blank, allow_destroy: true

  delegate :location, to: :user

  EMPLOYEE_OPTIONS = [["- Select Employee Strength -", nil], ["0-9", 1], ["0-49", 2], ["0-99", 3], ["0-499", 4], ["0-999", 5]]
  EMPLOYEE_OPTIONS_NAME = [[nil, nil], ["0-9", 1], ["0-49", 2], ["0-99", 3], ["0-499", 4], ["0-999", 5]]

  DESIGNATION_OPTIONS = [["- Select Designation -", nil], ["Founder", 1], ["CEO", 2], ["Co-Founder", 3], ["Founder/CEO", 4], ["Product Designer", 5], ["Marketing Exper", 6], ["Sales Expert", 7], ["CTO", 8], ["Software Engineer", 9], ["Media  Spokesperson", 10], ["Marketing", 11], ["Sales", 12], ["Other", 13]]

  def category_name
    BusinessLine[self.category].name if self.category
  end

  def employee_strength
    EMPLOYEE_OPTIONS_NAME[self.strength.to_i][0] if self.strength
  end

  def self.options
    [["- Select Founded Year -", nil]].concat((2010..2020).collect{|y| "#{y}" })
  end

  def self.by_business_line(users, line)
  # users.where("business_line like '%#{line}%'")
    users.each_with_index do |user, index|
      if user.startup.category.present?
        user.startup.category == line.to_i ? users : users[index] = nil
      else
        users[index] = nil
      end
    end
    users = users.compact
  end

  def self.by_funding_type(users, funding)
  # users.where("business_line like '%#{line}%'")
    users = users.order('created_at desc')
    users.each_with_index do |user, index|
      if user.startup.fundings.present?
        user.startup.fundings.map(&:funding_type).include?(funding.to_i) ? users : users[index] = nil
      else
        users[index] = nil
      end
    end
    users = users.compact
  end

  def self.employee_strength_options
    EMPLOYEE_OPTIONS
  end

  def self.designation_options
    DESIGNATION_OPTIONS
  end

  def self.search(params)
    results = all
    if params[:query].present?
      results = results.joins(:user).where("users.username LIKE :query OR users.email LIKE :query", query: "%#{params[:query]}%")
    end
    if params[:location].present?
      results = results.joins(:user).where("users.country LIKE :location OR users.city LIKE :location OR users.region LIKE :location", { location: "%#{params[:location]}%" })
    end
    if params[:address].present?
      results = results.where("address_line_1 LIKE :address OR address_line_2 LIKE :address", address: "%#{params[:address]}%")
    end
    results
  end
end
