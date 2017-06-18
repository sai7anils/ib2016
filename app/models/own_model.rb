# == Schema Information
#
# Table name: own_models
#
#  id                    :integer          not null, primary key
#  business_potencial_id :integer
#  revenue               :hstore           default({}), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class OwnModel < ActiveRecord::Base
  belongs_to :business_potencial
end
