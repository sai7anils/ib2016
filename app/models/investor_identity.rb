# == Schema Information
#
# Table name: investor_identities
#
#  id                         :integer          not null, primary key
#  investor_id                :integer
#  nationality_identity_proof :string
#  unique_identity_document   :string
#  previous_invesment_proofs  :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  indentity_proof            :string
#

class InvestorIdentity < ActiveRecord::Base
  belongs_to :investor
  has_many :attachments, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :attachments

  validates :indentity_proof, presence: true

  mount_uploader :indentity_proof, IdeaUploader
  mount_uploader :nationality_identity_proof, IdeaUploader
  mount_uploader :unique_identity_document, IdeaUploader
end
