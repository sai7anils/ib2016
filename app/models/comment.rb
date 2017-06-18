# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  message    :text
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  has_many :comments, foreign_key: :parent_id
  has_many :like_comments

  scope :order_asc, -> (){order('created_at ASC')}
end
