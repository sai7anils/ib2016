# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  idea_id         :integer
#  ip_address      :string
#  first_name      :string
#  last_name       :string
#  card_type       :string
#  card_expires_on :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :idea
  has_many :transactions, :class_name => "OrderTransaction"
  attr_accessor :card_number, :card_verification
  validate :validate_card, :on => :create
  # validate_on_create :validate_card

  delegate :business_idea, to: :idea, allow_nil: true

  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    if response.success?
      idea.update_attribute(:purchased_at, Time.now)
      idea.update_attribute(:status, "available")
    end
    response.success?
  end

  def price_in_cents
    (Idea::IDEA_CHARGE*100).round
  end

  private

  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << "error"
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
end
