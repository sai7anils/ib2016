# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  message    :text
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'association' do
    it { should have_many(:comments) }
    it { should have_many(:like_comments) }
    it { should belong_to(:user) }
    it { should belong_to(:idea) }
  end
end
