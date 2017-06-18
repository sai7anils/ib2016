# == Schema Information
#
# Table name: competitor_teams
#
#  id            :integer          not null, primary key
#  competitor_id :integer
#  name          :string
#  business_line :string
#  country       :string
#  revenue       :string
#  website       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CompetitorTeam < ActiveRecord::Base
  belongs_to :competitor
  belongs_to :competitive_protection
  def country_name
    country = Carmen::Country.coded(self.country) if self.country
    country.name rescue country
  end
end
