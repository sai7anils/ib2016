# == Schema Information
#
# Table name: business_teams
#
#  id                   :integer          not null, primary key
#  team_cappabilitie_id :integer
#  name                 :string
#  role                 :string
#  skills               :string
#  joined               :string
#  profile_image        :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class BusinessTeam < ActiveRecord::Base
  belongs_to :team_cappabilitie

  JOINED = [['Beginning', 1], ['Middle', 2], ['End', 3]]
  JOINED_NAME = [nil, 'Beginning', 'Middle', 'End']

  mount_uploader :profile_image, TeamCappabilitiesImageUploader
  validates_format_of :profile_image, :allow_blank => true, :with => %r{\.(png|jpg|jpeg)$}i, :message => "is the wrong type", :multiline => true

  def profile_avatar
    self.profile_image.blank? ? ActionController::Base.helpers.asset_path('Profile-Picture-Change-icon.png') : self.profile_image
  end
end
