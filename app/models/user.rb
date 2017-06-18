# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  user_type              :integer
#  country                :string
#  city                   :string
#  region                 :string
#  photo                  :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  term                   :boolean
#  slug                   :string
#

class User < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  extend FriendlyId

  enum user_type: {admin: 1, entrepreneur: 2, startup: 3, investor: 4}

  has_many :sent_messages, dependent: :destroy, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, dependent: :destroy, class_name: 'Message', foreign_key: :receiver_id
  has_many :ideas, dependent: :destroy, inverse_of: :user
  has_many :comments, dependent: :destroy, inverse_of: :user
  has_many :likes, dependent: :destroy, inverse_of: :user
  has_many :like_comments, dependent: :destroy, inverse_of: :user
  has_many :notifications, dependent: :destroy, inverse_of: :user
  has_many :events, dependent: :destroy, inverse_of: :user
  has_one :startup, dependent: :destroy, :autosave => true
  has_many :deals, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one :investor, dependent: :destroy, :autosave => true
  has_one :entrepreneur, dependent: :destroy, :autosave => true

  validates :username, presence: true, length: { minimum: 5, maximum: 16 }
  validates :user_type, presence: true
  validates :password, presence: true, on: :create, length: {maximum: 120}
  validates :password, length: {maximum: 120}, on: :update, allow_blank: true

  accepts_nested_attributes_for :startup, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :investor, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :entrepreneur, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable
  friendly_id :slug_candidates, use: [:slugged, :history, :finders]
  ratyrate_rater
  mount_uploader :photo, UserUploader

  scope :by_country, -> (c){where("country" => c)}
  scope :by_confirmed, -> (){where.not(confirmed_at: nil)}
  scope :by_keyword, -> (c){where("username LIKE ?", "%#{c}%")}
  scope :by_email, -> (c){where("email LIKE ?", "%#{c}%")}

  def slug_candidates
    [
      :fullname,
      [:fullname, :location]
    ]
  end

  def fullname
    if self.entrepreneur?
      "#{self.entrepreneur.first_name.capitalize} #{self.entrepreneur.last_name.capitalize}" rescue self.username
    elsif self.startup?
      self.startup.nil? ? self.username : self.startup.name
    elsif self.investor?
      self.investor.nil? ? self.username : self.investor.name
    else
      self.username
    end
  end

  def location
    country = Carmen::Country.coded(self.country) if self.country
    subregions = country.subregions unless country.nil?
    region = subregions.coded(self.region) if self.region && subregions.present?
    locations = []
    locations << country.name if country
    locations << region.name if region
    locations << self.city if self.city
    locations.join(', ')
  end

  def avatar
    self.photo.blank? ? ActionController::Base.helpers.asset_path('Profile-Picture-Change-icon.png') : self.photo
  end

  def like?(idea_id)
    return self.likes.exists?(idea_id: idea_id)
  end

  def like_comment?(comment_id)
    return self.like_comments.exists?(comment_id: comment_id)
  end

  def country_name
    country = Carmen::Country.coded(self.country) if self.country
    country.name rescue country
  end

  #def location
  #  location = self.city + " City, " + self.country_name.to_s
  #end

  def region_name
    country = Carmen::Country.coded(self.country) if self.country
    subregions = country.subregions unless country.nil?
    region = subregions.coded(self.region) if self.region && subregions.present?
    region.nil? ? nil : region.name
  end

  def profile_percentage
    is_nil = 0
    if self.entrepreneur?
      fields = self.entrepreneur.attributes
    elsif self.startup?
      fields = self.startup.attributes
    elsif self.investor?
      fields = self.investor.attributes
    end
    fields.keys().each do |key|
      if fields[key].nil? || fields[key] == ''
        is_nil = is_nil+1
      end
    end
    percent = (fields.count - is_nil).to_f / fields.count.to_f
    [number: percent*100 , text: number_to_percentage(percent*100, precision: 0)]
  end

  def self.email_valid?(email)
    User.find_by('email':email).present?
  end

  def self.search(params)
    users = all
    if params[:user_type].present? && User.user_types.keys.include?(params[:user_type])
      users = users.send(params[:user_type])
    end
    if params[:location].present?
      users = users.where("country LIKE :location OR city LIKE :location OR region LIKE :location", { location: "%#{params[:location]}%" })
    end
    if params[:query].present?
      users = users.where("username LIKE :query OR email LIKE :query", query: "%#{params[:query]}%")
    end
    users
  end

end
