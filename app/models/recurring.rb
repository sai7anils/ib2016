# == Schema Information
#
# Table name: recurrings
#
#  id                    :integer          not null, primary key
#  business_potencial_id :integer
#  no_account            :hstore           default({}), not null
#  charge                :hstore           default({}), not null
#  churn_rate            :hstore           default({}), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Recurring < ActiveRecord::Base
  belongs_to :business_potencial
end
