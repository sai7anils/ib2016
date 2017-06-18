# == Schema Information
#
# Table name: deals
#
#  id         :integer          not null, primary key
#  idea_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Deal < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  scope :by_idea, -> (id){where(idea_id: id)}
end
