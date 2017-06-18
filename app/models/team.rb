# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  name        :string
#  designation :integer
#  joined_date :date
#  email       :string
#  mobile      :string
#  linkedin    :string
#  skype       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  startup_id  :integer
#  image       :string
#

class Team < ActiveRecord::Base
  belongs_to :startup
  mount_uploader :image, UserUploader
  DESIGNATION_NAME = [[nil, nil], ["Founder", 1], ["CEO", 2], ["Co-Founder", 3], ["Founder/CEO", 4], ["Product Designer", 5], ["Marketing Exper", 6], ["Sales Expert", 7], ["CTO", 8], ["Software Engineer", 9], ["Media  Spokesperson", 10], ["Marketing", 11], ["Sales", 12], ["Othe", 13]]

  def designation_name
    DESIGNATION_NAME[self.designation.to_i][0] if self.designation
  end
end
