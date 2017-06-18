# == Schema Information
#
# Table name: fund_pitch_burns
#
#  id              :integer          not null, primary key
#  fund_startup_id :integer
#  pitch           :string
#  video           :string
#  document        :string
#  prefer_exit     :integer
#  validation      :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class FundPitchBurn < ActiveRecord::Base
  belongs_to :fund_startup
  has_many :attachments, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :attachments

  mount_uploader :pitch, PitchBurnUploader
  mount_uploader :video, VideoUploader

  validates :prefer_exit, presence: true, :numericality => { :greater_than => 0}
  validates :validation, presence: true, length: { minimum: 100, maximum: 600 }
  PREFER_EXIT = [['Merger & Acquisition (M&A)', 1], ['Initial Public Offering (IPO)', 2], ['Liquidation and close', 3], ['Others', 4]]

  def prefer_exit_in_text
    PREFER_EXIT.to_h.invert[prefer_exit]
  end
end
