# == Schema Information
#
# Table name: team_cappabilities
#
#  id               :integer          not null, primary key
#  business_idea_id :integer
#  crucial_skills   :integer
#  strength         :integer
#  team_attributes  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TeamCappabilitie < ActiveRecord::Base
  belongs_to :business_idea
  has_many :business_teams

  accepts_nested_attributes_for :business_teams, reject_if: :all_blank, allow_destroy: true
  validates :crucial_skills, presence: true
  validates :strength, presence: true
  validates :team_attributes, presence: true

  STRENGTH = (0..20).to_a
end
