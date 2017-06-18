# == Schema Information
#
# Table name: customer_analyses
#
#  id               :integer          not null, primary key
#  business_idea_id :integer
#  idea_solve       :text
#  big_customer     :string
#  about            :text
#  region           :string           default([]), is an Array
#  from_age         :string
#  to_age           :string
#  steps            :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class CustomerAnalysis < ActiveRecord::Base
  belongs_to :business_idea

  validates :idea_solve, presence: true, length: { minimum: 80, maximum: 400 }
  validates :big_customer, presence: true
  validates :region, presence: true
  validates :from_age, presence: true
  validates :to_age, presence: true
  validates :steps, presence: true, length: { minimum: 80, maximum: 400 }
  validates_length_of :about, :minimum => 80, :maximum => 400, :allow_blank => true

  AGES = (1..100).to_a

  def self.regions
    countries = [:us, :in, :au, :ca, :de, :gb, :il, :hk]
    regions = []
    countries.each do |c|
      CS.states(c).each do |k, v|
        regions << ["#{c}_#{k}" , v]
      end
    end
    regions
  end

  def big_customer_name
    BigCustomer.find(self.big_customer.to_i).name if self.big_customer.present?
  end

  def age_range
    text = ''
    text += self.from_age.nil? ? '0' : self.from_age
    text += '&nbsp;to&nbsp;'
    text += self.to_age.nil? ? '0' : self.to_age
    text.html_safe
  end

  def regions_name
    html = ''
    list = self.region if self.region.present?
    list.each do |l|
      CustomerAnalysis.regions.each do |r|
        if r.first == l
          html += r[1] + '<br />'
        end
      end
    end
    html.html_safe
  end
end

