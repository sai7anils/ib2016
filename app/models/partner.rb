# == Schema Information
#
# Table name: partners
#
#  id       :integer          not null, primary key
#  event_id :integer
#  name     :string
#  logo     :string
#

class Partner < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true

  mount_uploader :logo, PartnerLogoUploader
end
