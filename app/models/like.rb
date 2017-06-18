# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  scope :like_tooltip, -> (){all[1..-1]}
end
