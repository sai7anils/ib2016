# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  detail      :text
#  receiver_id :integer
#  sender_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  idea_id     :integer
#  seen        :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  belongs_to :idea, class_name: 'Idea', foreign_key: 'idea_id'

  validates :detail, presence: true
  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates :idea_id, presence: true

  scope :seen, -> (){update_all(seen: true)}
  scope :search, lambda {|id, search| where("sender_id = :person_id OR receiver_id =   :person_id", :person_id => id).order(id: 'desc').where('message LIKE ?', "%#{search}%")}
  scope :seen_by_user_id, lambda{|id| where(receiver_id: id).update_all(seen: true)}

  def self.by_person(person)
    where("sender_id = :person_id OR receiver_id =   :person_id", :person_id => person.id).order(id: 'desc')
  end

  def self.by_date(person, date)
    where("sender_id = :person_id OR receiver_id =   :person_id", :person_id => person.id).where(:created_at => (date.beginning_of_day..date.end_of_day))
  end

  def group_by_criteria
    created_at.to_date.to_s(:db)
  end
end
