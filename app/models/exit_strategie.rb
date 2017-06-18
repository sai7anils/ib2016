# == Schema Information
#
# Table name: exit_strategies
#
#  id                     :integer          not null, primary key
#  business_idea_id       :integer
#  business_exit_strategy :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class ExitStrategie < ActiveRecord::Base
  belongs_to :business_idea
  validates :business_exit_strategy, presence: true, length: { minimum: 80, maximum: 400 }
end
