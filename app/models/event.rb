# == Schema Information
#
# Table name: events
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  title               :string
#  entry_type          :integer
#  paid_entry_cost_min :integer
#  event_category      :integer
#  website             :string
#  event_image         :string
#  partner_logo        :string
#  description         :text
#  address_line_1      :string
#  address_line_2      :string
#  country             :string
#  city                :string
#  region              :string
#  zipcode             :string
#  event_partner       :text
#  event_from          :datetime
#  event_to            :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  timezone            :string
#  views               :integer          default(0)
#  event_time          :string
#  slug                :string
#

class Event < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  extend FriendlyId
  belongs_to :user
  has_many :partners
  before_validation :smart_add_url_protocol


  accepts_nested_attributes_for :partners, reject_if: :all_blank, allow_destroy: true

  EVENT_ENTRY_TYPE  = [["Free", 1], ["Paid", 2]]

  EVENT_CATEGORY_TYPE = [["Investor's Pitch", 1], ["Summit", 2], ["Conference", 3], ["SpeedDating", 4], ["Hackthon", 5], ["Others", 6]]

  EVENT_CATEGORY_TYPE_NAME = [[nil, nil], ["Investor's Pitch", 1], ["Summit", 2], ["Conference", 3], ["SpeedDating", 4], ["Hackthon", 5], ["Others", 6]]

  validates :paid_entry_cost_min, :allow_blank => true, :numericality => { :greater_than => 0}
  validates :title, presence: true
  validates :entry_type, presence: true
  validates :event_category, presence: true
  validates :address_line_1, presence: true
  validates :address_line_2, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :region, presence: true
  validates :event_from, presence: true
  validates :event_to, presence: true
  validates :event_time, presence: true
  validates :timezone, presence: true

  mount_uploader :event_image, EventImageUploader
  validates_format_of :event_image, :allow_blank => true, :with => %r{\.(png|jpg|jpeg)$}i, :message => "is the wrong type", :multiline => true

  friendly_id :title, use: [:slugged, :history, :finders]

  scope :by_keyword, -> (k){where("title LIKE '%#{k}%'")}
  scope :by_country, -> (c){where(:country => c)}
  scope :by_date, -> (d){where("event_from =? OR event_to =?", d, d)}
  scope :by_category, -> (c){where(:event_category => c)}

  def country_name
    country = Carmen::Country.coded(self.country) if self.country
    country.name rescue country
  end

  def region_name
    country = Carmen::Country.coded(self.country) if self.country
    subregions = country.subregions unless country.nil?
    region = subregions.coded(self.region) if self.region && subregions.present?
    region && region.name
  end

  def finished?
    current = Time.now
    self.event_to > current ? true : false
  end

  def category_name
    Event::EVENT_CATEGORY_TYPE_NAME[self.event_category][0] if self.event_category.present?
  end

  def event_time_content
    if (self.event_from.year == self.event_to.year)
      if (self.event_from.month == self.event_to.month)
        self.event_from.strftime("%A %b %d") + " - " + self.event_to.strftime("%d, %Y")
      else
        self.event_from.strftime("%A %b %d") + " - " + self.event_to.strftime("%b %d, %Y")
      end
    else
      self.event_from.strftime("%A %b %d, %Y") + " - " + self.event_to.strftime("%b %d, %Y")
    end
  end

  def event_cost_content
    (self.paid_entry_cost_min || 0).zero? ? 'Free' : number_to_currency(self.paid_entry_cost_min, :unit => "$ ")
  end

  def location
    self.address_line_1.to_s + ', ' + self.address_line_2.to_s + ', ' + self.city.to_s + ', ' + self.region_name.to_s + ',' + self.country_name.to_s
  end

  def my_event?(user)
    user.id == self.user.id ? true : false
  end

  protected
  def smart_add_url_protocol
    unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
      if self.website?
        self.website = "http://#{self.website}"
      end
    end
  end
end
