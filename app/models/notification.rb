# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  message           :text
#  user_id           :integer
#  idea_id           :integer
#  notification_type :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  author            :integer
#  seen              :boolean          default(FALSE)
#

class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  enum notification_type: {
    commented: 1,
    liked: 2,
    rated: 3,
    like_comment: 4,
    reply_comment: 5,
    replied_reply: 6
  }

  scope :by_user_id, lambda { |id| where(author: id).order(id: 'desc') }
  scope :unread_by_user_id, lambda { |id| where(author: id, seen: false).order(id: 'desc') }
  scope :seen_by_user_id, lambda { |id| where(author: id).update_all(seen: true) }
  scope :seen, -> (){ update_all(seen: true) }
  scope :search, lambda { |id, search| where(author: id).order(id: 'desc').where('message LIKE ?', "%#{search}%") }
end
