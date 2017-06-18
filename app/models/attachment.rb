# == Schema Information
#
# Table name: attachments
#
#  id                   :integer          not null, primary key
#  name                 :string
#  file                 :string
#  pitch_burn_id        :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  investor_identity_id :integer
#  fund_pitch_burn_id   :integer
#

require 'uri'
class Attachment < ActiveRecord::Base
  include ApplicationHelper
  mount_uploader :file, IdeaUploader
  belongs_to :pitch_burn
  belongs_to :investor_identity
  belongs_to :fund_pitch_burn

  def file_name
    if valid_url?(self.file.url)
      uri = valid_url?(self.file.url)
      [extn: File.extname(uri.path), name: File.basename(uri.path)]
    end
  end
end
