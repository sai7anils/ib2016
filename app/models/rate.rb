# == Schema Information
#
# Table name: rates
#
#  id            :integer          not null, primary key
#  rater_id      :integer
#  rateable_id   :integer
#  rateable_type :string
#  stars         :float            not null
#  dimension     :string
#  created_at    :datetime
#  updated_at    :datetime
#

class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true

  #attr_accessible :rate, :dimension

  def self.get_rating_statistic(idea_id, star)
    Rate.where("stars > ? AND stars < ? AND rateable_id = ?",star.to_f-1.0, star.to_f,idea_id).count
  end
end
