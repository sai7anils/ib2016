# == Schema Information
#
# Table name: competitors
#
#  id               :integer          not null, primary key
#  business_idea_id :integer
#  image            :string
#  about            :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Competitor < ActiveRecord::Base
  belongs_to :business_idea

  has_many :competitor_teams

  accepts_nested_attributes_for :competitor_teams, reject_if: :all_blank, allow_destroy: true
  validates :about, presence: true, length: { minimum: 80, maximum: 400 }

  mount_uploader :image, CompetatorImageUploader
  validates_format_of :image, :allow_blank => true, :with => %r{\.(png|jpg|jpeg)$}i, :message => "is the wrong type", :multiline => true

  def image_name
    img = self.image.present? ? self.image.url.split('/') : nil
    img[img.length - 1] unless img.nil?
  end
end
