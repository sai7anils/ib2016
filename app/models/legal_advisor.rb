# == Schema Information
#
# Table name: legal_advisors
#
#  id                   :integer          not null, primary key
#  fund_startup_id      :integer
#  professional_advisor :boolean
#  board_advisor        :boolean
#  member               :integer
#  professional_advice  :integer
#  board_manager        :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class LegalAdvisor < ActiveRecord::Base
  belongs_to :fund_startup
  MEMBER = (1..9).to_a

  validates :member, presence: true, :numericality => { :greater_than => 0, :smaller_than => 10}
  validates :professional_advice, presence: true, :numericality => { :greater_than => 0, :smaller_than => 9}
  validates :board_manager, presence: true, :numericality => { :greater_than => 0, :smaller_than => 9}
  validates :professional_advisor, inclusion: { in: [ true, false ] }
  validates :board_advisor, inclusion: { in: [ true, false ] }
end