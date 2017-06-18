# == Schema Information
#
# Table name: ideas
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  category_id  :integer
#  title        :string
#  description  :text
#  attachment   :string
#  views        :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  idea_type    :boolean          default(TRUE)
#  slug         :string
#  purchased_at :datetime
#  status       :string
#

class Idea < ActiveRecord::Base
  include ApplicationHelper
  extend FriendlyId

  TYPES = { false => 'Closed Idea', true => 'Public Idea'}

  belongs_to :user
  has_one :order
  has_many :comments, dependent: :delete_all, inverse_of: :idea
  has_many :likes, dependent: :delete_all, inverse_of: :idea
  has_many :notifications, dependent: :delete_all, inverse_of: :idea
  has_one :business_idea, dependent: :destroy, :autosave => true
  has_many :deals, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates_format_of :attachment, :with => %r{\.(png|jpg|jpeg)$}i, :message => "is the wrong type", :multiline => true, :allow_blank => true
  validates :attachment, presence: true, if: :created_with_business_idea?
  validates :category_id, presence: true, if: :created_with_business_idea?
  validates :title, presence: true
  validates :description, presence: true, if: :created_with_business_idea?

  accepts_nested_attributes_for :business_idea, reject_if: proc { |attributes| attributes['business_line'].blank? }, allow_destroy: true

  mount_uploader :attachment, UserUploader

  IDEA_CHARGE = 49

  ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'
  friendly_id :title, use: [:slugged, :history, :finders]

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :username, to: :user, allow_nil: true

  scope :by_keyword, -> (q){where{ title.like "%#{q}%" }}
  scope :by_name_status, -> (name) {where("title=? and status =?", name, "pending")}
  scope :by_category, -> (c){where(:category_id => c)}
  scope :by_country, -> (c){joins(:user).where("users.country" => c)}
  scope :by_country_category, -> (country, c){joins(:user).where("users.country" => country, :category_id => c)}
  scope :by_closed, -> (){where(:idea_type => false)}
  scope :by_public, -> (){where(:idea_type => true)}
  scope :by_date, -> (d){where("DATE(created_at) =?", d)}
  scope :by_business_line, -> (c){joins(:business_idea).where("business_ideas.business_line" => c)}
  scope :by_idea_stage, -> (c){joins(:business_idea).where("business_ideas.idea_stage" => c)}
  scope :by_patent, -> (c){joins(:business_idea).where("business_ideas.ip_patent" =>c)}
  scope :by_category_name, -> (name){Idea.all.select { |c| c.category.attributes['name'] == name }}

  def category
    Category.find(self.category_id)
  end

  def self.category?(name)
    category = Category.all.select { |c| c.attributes['name'] == name }
    category.present?
  end

  def like_per_views
    return 0 if self.likes.count.zero?
    (self.likes.count.to_f / self.views.to_f * 100.0).to_i
  end

  def total_rating
    Rate.where(rateable_type: "Idea", rateable_id: self.id).count
  end

  def rating
    total = Rate.where(rateable_type: "Idea", rateable_id: self.id).count
    total_stars = Rate.where(rateable_type: "Idea", rateable_id: self.id).sum(:stars)
    return total > 0 ? (( total_stars * 2 ) / total).round(1) : 0.0
  end

  def like_description
    if self.likes.count.zero?
      description = "Be the first like this"
    elsif self.likes.count == 1
      description = ''
      if self.likes.first.user
        description =  "<a href='#{get_profile(self.likes.first.user)}'><span style='color:#78C2E9;cursor:pointer;'>#{self.likes.first.user.fullname.blank? ? self.likes.first.user.username : self.likes.first.user.fullname}</span></a> likes this".html_safe
      end
    else
      offset = rand(self.likes.count)
      description = "<a href='#{get_profile(self.likes.first.user)}'><span style='color:#78C2E9;cursor:pointer;'>#{self.likes.first.user.fullname.blank? ? self.likes.first.user.username : self.likes.first.user.fullname}</span></a> and <span data-id='#{self.id}' class='tooltip-like show-all-idea-like'> #{self.likes.count - 1} others</span> likes this".html_safe
    end
  end

  def image
    imgs = ['thumbs-img1.jpg', 'thumbs-img2.jpg', 'thumbs-img3.jpg', 'thumbs-img4.jpg']
    self.attachment.present? ? self.attachment : imgs.sample
  end

  def type_name
    TYPES[self.idea_type]
  end

  def my_idea?(user)
    user.id == self.user.id ? true : false
  end

  def created_with_business_idea?
    self.idea_type == true
  end

  def self.by_business_location(location)
    ideas = self.joins(:business_idea)
    arr = []
    ideas.each do |idea|
      if self.in_location?(idea, location)
        arr << idea
      end
    end
    arr
  end

  def self.in_location?(idea, location)
    if !idea.business_idea.nil? && !idea.business_idea.customer_analysis.nil?
      idea.business_idea.customer_analysis.region.include? location
    end
  end

end
