# == Schema Information
#
# Table name: competitive_protections
#
#  id                    :integer          not null, primary key
#  business_potential_id :integer
#  strategy              :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class CompetitiveProtection < ActiveRecord::Base
  has_many :competitor_teams, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :competitor_teams, reject_if: :all_blank, allow_destroy: true
  belongs_to :business_potential

  validates :strategy, presence: true, length: { minimum: 100, maximum: 600 }
end
