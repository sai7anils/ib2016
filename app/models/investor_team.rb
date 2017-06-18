# == Schema Information
#
# Table name: investor_teams
#
#  id          :integer          not null, primary key
#  name        :string
#  designation :integer
#  joined_date :date
#  email       :string
#  mobile      :string
#  linkedin    :string
#  skype       :string
#  investor_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#

class InvestorTeam < ActiveRecord::Base
  belongs_to :investor

  mount_uploader :image, InvestorTeamUploader

  DESIGNATION_NAME = [[nil, nil], ["Director", 1], ["Partner", 2], ["Investment analyst", 3], ["Investment advisor", 4], ["Finance professional", 5], ["Others", 6]]

  def designation_name
    DESIGNATION_NAME[self.designation.to_i][0] if self.designation
  end
end
