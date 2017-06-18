# == Schema Information
#
# Table name: like_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LikeComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
end
