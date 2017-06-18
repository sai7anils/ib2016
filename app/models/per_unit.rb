# == Schema Information
#
# Table name: per_units
#
#  id                    :integer          not null, primary key
#  business_potencial_id :integer
#  sale                  :hstore           default({}), not null
#  price                 :hstore           default({}), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class PerUnit < ActiveRecord::Base
  belongs_to :business_potencial
end
