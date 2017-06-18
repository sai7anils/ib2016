# == Schema Information
#
# Table name: order_transactions
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  action        :string
#  amount        :integer
#  success       :boolean
#  authorization :string
#  message       :string
#  params        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OrderTransaction < ActiveRecord::Base
  belongs_to :order
  serialize :params

  def response=(response)
    self.success       = response.success?
    self.authorization = response.authorization
    self.message       = response.message
    self.params        = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success       = false
    self.authorization = nil
    self.message       = e.message
    self.params        = {}
  end

end
