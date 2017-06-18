# == Schema Information
#
# Table name: pitch_burns
#
#  id                :integer          not null, primary key
#  business_idea_id  :integer
#  your_own          :string
#  your_video        :string
#  documents         :string
#  your_idea_legally :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'uri'
class PitchBurn < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :business_idea
  has_many :attachments, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :attachments
  validates :your_own, presence: true
  validates :your_idea_legally, presence: true, length: { minimum: 80, maximum: 400 }

  mount_uploader :your_own, PitchBurnUploader
  mount_uploader :your_video, VideoUploader

  def your_own_name
    if valid_url?(self.your_own.url)
      uri = valid_url?(self.your_own.url)
      [extn: File.extname(uri.path), name: File.basename(uri.path)]
    end
  end

  def video_url
    if valid_url?(self.your_video.url)
      uri = valid_url?(self.your_video.url)
      [extn: File.extname(uri.path), name: File.basename(uri.path), url: "https://#{Rails.application.secrets.aws_dir}.s3.amazonaws.com#{uri.path}", thumb: 'img-video.jpg']
    end
  end
end
