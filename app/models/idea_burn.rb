# == Schema Information
#
# Table name: idea_burns
#
#  id                :integer          not null, primary key
#  name              :string
#  url               :string
#  meta_description  :text
#  meta_keywords     :text
#  seo_title         :string
#  mail_from_address :string
#  default_currency  :string
#  facebook          :string
#  linkedin          :string
#  instagram         :string
#  tumblr            :string
#  twitter           :string
#  video             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class IdeaBurn < ActiveRecord::Base
  validates :name, presence: true
  validates :seo_title, presence: true
  validates :video, presence: true, format: { with: /\A#{URI::regexp(['http', 'https'])}\z/, on: :update }
  validates :mail_from_address, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :update }
end
