require 'rails_helper'

RSpec.describe User::BusinessIdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:business_idea) { FactoryGirl.create(:business_idea) }
  before :each do
    sign_in user
  end
  describe 'get method' do
    it 'go to index' do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:message)).to be_present
      expect(assigns(:identity)).to be_present
    end

    it 'go to show and redirect_to business ideas' do
      get :show, id: business_idea.idea_id
      expect(response).to redirect_to(user_business_ideas_path)
    end

    it 'go to show' do
      business_idea.idea.update_column(:user_id, user.id)
      get :show, id: business_idea.idea_id
      expect(response).to render_template(:show)
      expect(assigns(:message)).to be_present
    end
  end
end
