# == Schema Information
#
# Table name: per_hours
#
#  id                    :integer          not null, primary key
#  business_potencial_id :integer
#  billable              :hstore           default({}), not null
#  hour_rate             :hstore           default({}), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class PerHour < ActiveRecord::Base
  belongs_to :business_potencial
end
